<?php
namespace App\Controller;
use App\Utility\JwtTokenGenerator;

/**
 * Users Controller
 *
 * @method \App\Model\Entity\User[]|\Cake\Datasource\ResultSetInterface paginate($object = null, array $settings = [])
 */
class UsersController extends AppController
{
    public function initialize(): void {
        parent::initialize();
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Authentication.Authentication');

        $this->Authentication->addUnauthenticatedActions(['login' , 'register']);
    }
    
    /**
     * @OA\Post(
     *     path="/users/login",
     *     summary="Logowanie użytkownika",
     *     description="Endpoint do logowania użytkownika i generowania tokenu JWT",
     *     tags={"Users"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"email", "password"},
     *             @OA\Property(property="email", type="string", example="user@example.com"),
     *             @OA\Property(property="password", type="string", example="securepassword123")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Zwraca token JWT",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="token", type="string", example="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Nieprawidłowe dane logowania",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Nieprawidłowe dane logowania")
     *         )
     *     )
     * )
     */
    public function login() {
        $this->request->allowMethod(['post']);
        $result = $this->Authentication->getResult();
        if ($result->isValid()) {
            $user = $result->getData();
            $token = JwtTokenGenerator::generateToken($user);
            $this->set([
                'success' => true,
                'token' => $token,
            ]);
        } else {
            $this->response = $this->response->withStatus(401);
            $this->set([
                'success' => false,
                'message' => 'Nieprawidłowe dane logowania',
            ]);
        }
        
        // Użyj tylko jednej metody do serializacji
        $this->viewBuilder()->setClassName('Json');
        $this->viewBuilder()->setOption('serialize', ['success', 'token', 'message']);
    }

    /**
     * @OA\Post(
     *     path="/users/register",
     *     summary="Rejestracja nowego użytkownika",
     *     tags={"Users"},
     *     description="Endpoint umożliwia rejestrację nowego użytkownika w systemie.",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Dane użytkownika do rejestracji",
     *         @OA\JsonContent(
     *             type="object",
     *             required={"email", "password"},
     *             @OA\Property(property="email", type="string", example="user@example.com", description="Adres email użytkownika"),
     *             @OA\Property(property="password", type="string", example="securepassword123", description="Hasło użytkownika (min. 8 znaków)")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Rejestracja zakończona pomyślnie",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Rejestracja zakończona pomyślnie")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas rejestracji",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Nie udało się zapisać użytkownika."),
     *             @OA\Property(property="errors", type="object", example={
     *                 "email": {"Podany adres email jest już zajęty"},
     *                 "password": {"Hasło musi mieć co najmniej 8 znaków"}
     *             })
     *         )
     *     )
     * )
     */
    public function register() {
        $this->request->allowMethod(['post']); // Tylko metoda POST jest akceptowana
        $user = $this->Users->newEmptyEntity();

        // Pobierz dane z żądania
        $data = $this->request->getData();
        $user = $this->Users->patchEntity($user, $data);

        // Walidacja i zapis użytkownika
        try {
            if ($this->Users->save($user)) {
                $this->set([
                    'success' => true,
                    'message' => 'Rejestracja zakończona pomyślnie',
                ]);
            } else {
                $this->set([
                    'success' => false,
                    'message' => 'Nie udało się zarejestrować użytkownika',
                    'errors' => $user->getErrors(),
                ]);
            }
        } catch (PersistenceFailedException $e) {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Nie udało się zapisać użytkownika.',
                'errors' => $e->getMessage(),
            ]);
        }

        
        $this->viewBuilder()->setOption('serialize', ['success', 'errors', 'message']);
    }


    /**
     * @OA\Post(
     *     path="/users/logout",
     *     summary="Wylogowanie użytkownika",
     *     tags={"Users"},
     *     description="Endpoint umożliwia wylogowanie zalogowanego użytkownika. Token uwierzytelniający zostaje unieważniony po stronie klienta.",
     *     security={{"bearerAuth":{}}},
     *     @OA\Response(
     *         response=200,
     *         description="Wylogowanie zakończone pomyślnie",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Zostałeś poprawnie wylogowany")
     *         )
     *     )
     * )
     */
    public function logout()
    {
        $this->Authentication->logout();
        $this->set([
            'success' => true,
            'message' => 'Zostałeś poprawnie wylogowany',
        ]);
        $this->viewBuilder()->setOption('serialize', ['success', 'message']);
    }
}
