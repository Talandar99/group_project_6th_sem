<?php
namespace App\Error;

use Cake\Error\ExceptionRenderer;
use Psr\Http\Message\ResponseInterface;
use Cake\Http\Response;

class JsonExceptionRenderer extends ExceptionRenderer
{
    /**
     *
     * @param \Throwable $exception The exception to render.
     * @return \Psr\Http\Message\ResponseInterface
     */
    public function render(): ResponseInterface
    {
        $response = new Response();

        return $response->withType('application/json')
        ->withStringBody(json_encode([
            'success' => false,
            'message' => $this->error->getMessage(),
            'error' => [
                'file' => $this->error->getFile(),
                'line' => $this->error->getLine()
            ]
        ]));
    }
}
