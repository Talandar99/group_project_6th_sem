<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

class Product extends Entity 
{
    protected $_accessible = [
        '*' => true, // Allows mass assignment for all fields
        'id' => false, // Prevent modification of the ID field
    ];

    protected function _getImageUrl($imageUrl) {
        if ($imageUrl) {
            $baseUrl = \Cake\Core\Configure::read('App.fullBaseUrl');
            return $baseUrl . '/' . $imageUrl;
        }
        return null;
    }
}