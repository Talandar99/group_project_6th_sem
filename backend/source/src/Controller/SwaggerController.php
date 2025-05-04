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
     *     title="Group project 6th API",
     *     version="1.0.0",
     * )
     */
    public function api()
    {
        $openapi = Generator::scan([ROOT . '/src']);
        $this->response = $this->response->withType('application/json')->withStringBody($openapi->toJson());
        return $this->response;
    }
}
