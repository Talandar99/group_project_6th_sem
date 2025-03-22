<?php
namespace App\Controller;

use Cake\Controller\Controller;
use OpenApi\Generator;

/**
 * Swagger Controller
 */
class SwaggerController extends Controller
{
    public function index() {
        $this->viewBuilder()->setLayout('empty');
        $this->render('index');
    }
    /**
     * @OA\Info(
     *     title="My API",
     *     version="1.0.0",
     *     description="A brief description of your API",
     *     termsOfService="http://example.com/terms/",
     *     contact={
     *         "email": "support@example.com"
     *     },
     *     license={
     *         "name": "Apache 2.0",
     *         "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
     *     }
     * )
     */
    public function api()
    {
        $openapi = Generator::scan([ROOT . '/src']);
        $this->response = $this->response->withType('application/json')->withStringBody($openapi->toJson());
        return $this->response;
    }
}
