<?php
namespace App\Controller;

use App\Controller\AppController;

class ProductsController extends AppController {
    public function initialize(): void {
        parent::initialize();
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Authentication.Authentication');

        $this->Authentication->addUnauthenticatedActions(['index']);
    }

    /**
     * @OA\Get(
     *     path="/products",
     *     summary="Pobranie listy produktów",
     *     description="Endpoint zwraca listę produktów z paginacją oraz ilość wszystkich rekordów w tabeli.",
     *     tags={"Products"},
     *     @OA\Parameter(
     *         name="page",
     *         in="query",
     *         description="Numer strony do pobrania (domyślnie 1)",
     *         required=false,
     *         @OA\Schema(type="integer", example=1)
     *     ),
     *     @OA\Parameter(
     *         name="limit",
     *         in="query",
     *         description="Liczba elementów na stronę (domyślnie 10)",
     *         required=false,
     *         @OA\Schema(type="integer", example=10)
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Lista produktów",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="count", type="integer", example=100),
     *             @OA\Property(
     *                 property="data",
     *                 type="array",
     *                 @OA\Items(
     *                     @OA\Property(property="id", type="integer", example=1),
     *                     @OA\Property(property="product_name", type="string", example="Product 1"),
     *                     @OA\Property(property="price", type="number", format="float", example=19.99),
     *                     @OA\Property(property="amount_in_stock", type="integer", example=100),
     *                     @OA\Property(property="description", type="string", example="Description of product")
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd walidacji lub problem z paginacją",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Invalid pagination parameters")
     *         )
     *     )
     * )
     */
    public function index() {
        $this->paginate = [
            'limit' => 10,
            'order' => [
                'Products.id' => 'desc',
            ]
        ];
    
        $products = $this->paginate($this->Products);
        $count = $this->Products->find('all')->count();

        $this->set([
            'success' => true,
            'count' => $count,
            'data' => $products,
        ]);
        $this->viewBuilder()->setOption('serialize', ['success', 'count', 'data']);
        $this->viewBuilder()->setClassName('Json');
    }

    /**
     * @OA\Post(
     *     path="/products/add",
     *     summary="Dodanie nowego produktu",
     *     description="Endpoint umożliwia dodanie nowego produktu.",
     *     tags={"Products"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"product_name", "price", "amount_in_stock"},
     *             @OA\Property(property="product_name", type="string", example="New Product"),
     *             @OA\Property(property="price", type="number", format="float", example=29.99),
     *             @OA\Property(property="amount_in_stock", type="integer", example=50),
     *             @OA\Property(property="description", type="string", example="Optional description")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Produkt dodany pomyślnie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Product added successfully")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas dodawania produktu",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Failed to add product")
     *         )
     *     )
     * )
     */
    public function add() {
        $this->request->allowMethod(['post']);
        $product = $this->Products->newEmptyEntity();
        $product = $this->Products->patchEntity($product, $this->request->getData());

        if ($this->Products->save($product)) {
            $this->set([
                'success' => true,
                'message' => 'Product added successfully',
            ]);
        } else {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Failed to add product',
                'errors' => $product->getErrors(),
            ]);
        }

        $this->viewBuilder()->setOption('serialize', ['success', 'message', 'errors']);
    }

    /**
     * @OA\Put(
     *     path="/products/edit/{id}",
     *     summary="Edycja produktu",
     *     description="Endpoint umożliwia edycję istniejącego produktu.",
     *     tags={"Products"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID produktu",
     *         @OA\Schema(type="integer", example=1)
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="product_name", type="string", example="Updated Product"),
     *             @OA\Property(property="price", type="number", format="float", example=19.99),
     *             @OA\Property(property="amount_in_stock", type="integer", example=120),
     *             @OA\Property(property="description", type="string", example="Updated description")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Produkt zaktualizowany pomyślnie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Product updated successfully")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas aktualizacji produktu",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Failed to update product")
     *         )
     *     )
     * )
     */
    public function edit($id = null) {
        $this->request->allowMethod(['put']);
        $product = $this->Products->get($id);
        $product = $this->Products->patchEntity($product, $this->request->getData());

        if ($this->Products->save($product)) {
            $this->set([
                'success' => true,
                'message' => 'Product updated successfully',
            ]);
        } else {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Failed to update product',
                'errors' => $product->getErrors(),
            ]);
        }

        $this->viewBuilder()->setOption('serialize', ['success', 'message', 'errors']);
    }

    /**
     * @OA\Delete(
     *     path="/products/delete/{id}",
     *     summary="Usunięcie produktu",
     *     description="Endpoint umożliwia usunięcie produktu.",
     *     tags={"Products"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID produktu",
     *         @OA\Schema(type="integer", example=1)
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Produkt usunięty pomyślnie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Product deleted successfully")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas usuwania produktu",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Failed to delete product")
     *         )
     *     )
     * )
     */
    public function delete($id = null) {
        $this->request->allowMethod(['delete']);
        $product = $this->Products->get($id);

        if ($this->Products->delete($product)) {
            $this->set([
                'success' => true,
                'message' => 'Product deleted successfully',
            ]);
        } else {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Failed to delete product',
            ]);
        }

        $this->viewBuilder()->setOption('serialize', ['success', 'message']);
    }
}
