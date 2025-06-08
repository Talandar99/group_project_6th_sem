<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Event\EventInterface;

class PurchaseHistoryController extends AppController {
    public function initialize(): void {
        parent::initialize();
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Authentication.Authentication');

        $this->Authentication->addUnauthenticatedActions([]);
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
     *     path="/purchase-history",
     *     summary="Get all purchase history records",
     *     description="Returns a list of purchase history records stored in the database.",
     *     operationId="getPurchaseHistory",
     *     tags={"Purchase History"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Response(
     *         response=200,
     *         description="Successful response",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(
     *                 property="data",
     *                 type="array",
     *                 @OA\Items(
     *                     type="object",
     *                     @OA\Property(property="id", type="integer", example=1),
     *                     @OA\Property(property="product_name", type="string", example="Laptop XYZ"),
     *                     @OA\Property(property="price", type="number", format="float", example=999.99),
     *                     @OA\Property(property="amount_in_stock", type="integer", example=10),
     *                     @OA\Property(property="description", type="string", example="A high-performance laptop"),
     *                     @OA\Property(property="image_url", type="string", example="https://example.com/images/laptop.jpg"),
     *                     @OA\Property(property="user_id", type="integer", example=5),
     *                     @OA\Property(property="created_at", type="string", format="date-time", example="2025-06-07T23:35:00Z")
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - Authentication required"
     *     ),
     *     @OA\Response(
     *         response=500,
     *         description="Internal Server Error"
     *     )
     * )
     */
    public function index() {
        $identity = $this->Authentication->getIdentity();
        $userId = $identity->getIdentifier();

        $history = $this->PurchaseHistory->find('all')->where(['user_id' => $userId]);

        $this->set([
            'success' => true,
            'data' => $history->toArray(),
        ]);
        $this->viewBuilder()->setOption('serialize', ['success', 'data']);
        $this->viewBuilder()->setClassName('Json');
    }

    /**
     * @OA\Post(
     *     path="/purchase-history/add",
     *     summary="Add a new purchase history record",
     *     description="Adds a new record to the purchase history based on the provided product ID.",
     *     operationId="addPurchaseHistory",
     *     tags={"Purchase History"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="product_id", type="integer", example=1)
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Record created successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="data", type="object")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Product not found"
     *     ),
     *     @OA\Response(
     *         response=500,
     *         description="Internal Server Error"
     *     )
     * )
     */
    public function add() {
        $this->request->allowMethod(['post']);

        $productId = $this->request->getData('product_id');

        $identity = $this->Authentication->getIdentity();
        $userId = $identity->getIdentifier();

        $product = $this->fetchTable('Products')->find()
            ->where(['id' => $productId])
            ->first();

        if (!$product) {
            $this->set(['success' => false, 'message' => 'Product not found']);
        }

        if (!$userId) {
            $this->set(['success' => false, 'message' => 'User id unknown']);
        }

        $purchaseHistory = $this->PurchaseHistory->newEntity([
            'product_name' => $product->product_name,
            'price' => $product->price,
            'amount_in_stock' => $product->amount_in_stock,
            'description' => $product->description,
            'image_url' => $product->image_url,
            'user_id' => $userId,
            'created_at' => date('Y-m-d H:i:s')
        ]);

        if ($this->PurchaseHistory->save($purchaseHistory)) {
            $this->set(['success' => true, 'data' => $purchaseHistory]);
        } else {
            $this->set(['success' => false, 'message' => 'Could not save purchase history']);
        }
        
        $this->viewBuilder()->setOption('serialize', ['success', 'data']);
        $this->viewBuilder()->setClassName('Json');
    }
}
