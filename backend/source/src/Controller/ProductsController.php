<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Event\EventInterface;

class ProductsController extends AppController {
    public function initialize(): void {
        parent::initialize();
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Authentication.Authentication');

        $this->Authentication->addUnauthenticatedActions(['index']);
    }
    
    public function beforeFilter(EventInterface $event)
    {
        parent::beforeFilter($event);

        // Dodaj nagłówki CORS do odpowiedzi
        $this->response = $this->response
            ->withHeader('Access-Control-Allow-Origin', '*')  // lub konkretna domena np. 'https://example.com'
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
            ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With');

        // Obsługa zapytań preflight - dla metod OPTIONS
        if ($this->request->getMethod() === 'OPTIONS') {
            // Ustaw status 200 i zakończ przetwarzanie (żądanie preflight)
            $this->response = $this->response->withStatus(200);
            return $this->response;
        }

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
     *                     @OA\Property(property="description", type="string", example="Description of product"),
     *                     @OA\Property(property="image_url", type="string", example="images/img-1.jpg")
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
            'data' => $products->toArray(),
        ]);
        $this->viewBuilder()->setOption('serialize', ['success', 'count', 'data']);
        $this->viewBuilder()->setClassName('Json');
    }

    /**
     * @OA\Post(
     *     path="/products/add",
     *     summary="Dodanie nowego produktu",
     *     description="Endpoint umożliwia dodanie nowego produktu, wraz ze zdjęciem.",
     *     tags={"Products"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="multipart/form-data",
     *             @OA\Schema(
     *                 type="object",
     *                 required={"product_name", "price", "amount_in_stock", "image"},
     *                 @OA\Property(property="product_name", type="string", example="New Product"),
     *                 @OA\Property(property="price", type="number", format="float", example=29.99),
     *                 @OA\Property(property="amount_in_stock", type="integer", example=50),
     *                 @OA\Property(property="description", type="string", example="Optional description"),
     *                 @OA\Property(property="image", type="string", format="binary", example="image_file.jpg")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Produkt dodany pomyślnie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Product added successfully"),
     *             @OA\Property(property="image_url", type="string", example="img/product_image.jpg")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas dodawania produktu",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Failed to add product"),
     *             @OA\Property(property="errors", type="array", @OA\Items(type="string"))
     *         )
     *     )
     * )
     */
    public function add() {
        $this->request->allowMethod(['post']);
        $product = $this->Products->newEmptyEntity();
        $data = $this->request->getData();

        $file = $this->request->getData('image');
        if ($file && $file->getError() === UPLOAD_ERR_OK) {
            $filePath = WWW_ROOT . 'img' . DS . $file->getClientFilename();
            $file->moveTo($filePath);
            $data['image_url'] = 'img' . DS . $file->getClientFilename();
        }

        $product = $this->Products->patchEntity($product, $data);

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
        $this->viewBuilder()->setClassName('Json');
    }

    /**
     * @OA\Post(
     *     path="/products/edit/{id}",
     *     summary="Edycja produktu",
     *     description="Endpoint umożliwia edycję istniejącego produktu, wraz z możliwością aktualizacji zdjęcia.",
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
     *         @OA\MediaType(
     *             mediaType="multipart/form-data",
     *             @OA\Schema(
     *                 type="object",
     *                 required={"product_name", "price", "amount_in_stock", "image"},
     *                 @OA\Property(property="product_name", type="string", example="Updated Product"),
     *                 @OA\Property(property="price", type="number", format="float", example=19.99),
     *                 @OA\Property(property="amount_in_stock", type="integer", example=120),
     *                 @OA\Property(property="description", type="string", example="Updated description"),
     *                 @OA\Property(property="image", type="string", format="binary", example="updated_image.jpg")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Produkt zaktualizowany pomyślnie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Product updated successfully"),
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas aktualizacji produktu",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Failed to update product"),
     *             @OA\Property(property="errors", type="array", @OA\Items(type="string"))
     *         )
     *     )
     * )
     */
    public function edit($id = null) {
        $this->request->allowMethod(['post']);
        $product = $this->Products->get($id);
        $data = $this->request->getData();

        $file = $this->request->getData('image');
        if ($file && $file->getError() === UPLOAD_ERR_OK) {
            $filePath = WWW_ROOT . 'img' . DS . $file->getClientFilename();
            $file->moveTo($filePath);
            $data['image_url'] = 'img' . DS . $file->getClientFilename();
        } else {
            $data['image_url'] = $product->image_url;
        }

        $product = $this->Products->patchEntity($product, $data);

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
        $this->viewBuilder()->setClassName('Json');
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
        $this->viewBuilder()->setClassName('Json');
    }
}
