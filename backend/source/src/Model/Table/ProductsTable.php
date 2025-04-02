<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class ProductsTable extends Table {
    public function initialize(array $config): void {
        parent::initialize($config);

        $this->setTable('products'); // Nazwa tabeli w bazie danych
        $this->setDisplayField('product_name'); // Pole używane jako etykieta
        $this->setPrimaryKey('id'); // Klucz główny
    }

    public function validationDefault(Validator $validator): Validator {
        $validator
            ->notEmptyString('product_name', 'Product name is required')
            ->maxLength('product_name', 255, 'Product name must be less than 255 characters')
            ->notEmptyString('price', 'Price is required')
            ->numeric('price', 'Price must be numeric')
            ->greaterThanOrEqual('price', 0, 'Price must be zero or more')
            ->notEmptyString('amount_in_stock', 'Amount in stock is required')
            ->integer('amount_in_stock', 'Amount in stock must be an integer')
            ->greaterThanOrEqual('amount_in_stock', 0, 'Amount in stock must be zero or more')
            ->allowEmptyString('description'); // Pole opcjonalne
        return $validator;
    }
}
