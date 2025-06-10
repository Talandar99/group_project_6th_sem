<?php
namespace App\Controller;
use App\Utility\JwtTokenGenerator;
use Cake\Event\EventInterface;

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
     *             @OA\Property(property="message", type="string", example="Poprawnie zalogowano"),
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
                'message' => 'Poprawnie zalogowano',
                'token' => $token,
                // 'message' => $user
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

        $email = $data['email'] ?? null;
        $query = $this->Users->find()
        ->where([
            'email IS' => $email
        ])
        ->first();
        if ($query) {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Podany adres e-mail jest już zarejestrowany.',
            ]);
        } else {
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
        }

        
        $this->viewBuilder()->setClassName('Json');
        $this->viewBuilder()->setOption('serialize', ['success', 'errors', 'message']);
    }

    /**
     * @OA\Put(
     *     path="/users/edit",
     *     summary="Edycja danych użytkownika",
     *     description="Endpoint umożliwia edycję danych zalogowanego użytkownika.",
     *     tags={"Users"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"email"},
     *             @OA\Property(property="email", type="string", example="new_user@example.com"),
     *             @OA\Property(property="password", type="string", example="newsecurepassword123")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Dane użytkownika zostały zaktualizowane",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Dane zostały zaktualizowane pomyślnie")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Błąd podczas aktualizacji danych",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Nie udało się zaktualizować danych użytkownika"),
     *             @OA\Property(property="errors", type="object", example={
     *                 "email": {"Podany adres email jest już zajęty"},
     *                 "password": {"Hasło musi mieć co najmniej 8 znaków"}
     *             })
     *         )
     *     )
     * )
     */
    public function edit() {
        $this->request->allowMethod(['put', 'patch']); // Akceptujemy PUT i PATCH

        // Uzyskaj aktualnie zalogowanego użytkownika
        $identity = $this->Authentication->getIdentity();
        
        if (!$identity) {
            $this->response = $this->response->withStatus(401);
            $this->set([
                'success' => false,
                'message' => 'Nie jesteś zalogowany',
            ]);
            return;
        }

        // Pobierz dane z żądania
        $data = array_filter($this->request->getData(), function ($value) {
            return $value !== null && $value !== '';
        }, ARRAY_FILTER_USE_BOTH);

        // Załaduj dane do aktualnie zalogowanego użytkownika
        $userId = $identity->getIdentifier();
        $user = $this->Users->get($userId);
        $user = $this->Users->patchEntity($user, $data);

        // Zapisz zmiany w bazie danych
        if ($this->Users->save($user)) {
            $this->set([
                'success' => true,
                'message' => 'Dane zostały zaktualizowane pomyślnie',
            ]);
        } else {
            $this->response = $this->response->withStatus(400);
            $this->set([
                'success' => false,
                'message' => 'Nie udało się zaktualizować danych użytkownika',
                'errors' => $user->getErrors(),
            ]);
        }

        $this->viewBuilder()->setClassName('Json');
        $this->viewBuilder()->setOption('serialize', ['success', 'message', 'errors']);
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
     *
     * @OA\SecurityScheme(
     *     securityScheme="bearerAuth",
     *     type="http",
     *     scheme="bearer",
     *     bearerFormat="JWT",
     *     description="Wprowadź token JWT uzyskany podczas logowania."
     * )
     */
    public function logout()
    {
        $this->request->allowMethod(['post']);
        $this->Authentication->logout();
        $this->set([
            'success' => true,
            'message' => 'Zostałeś poprawnie wylogowany',
        ]);
        $this->viewBuilder()->setClassName('Json');
        $this->viewBuilder()->setOption('serialize', ['success', 'message']);
    }
}
