<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class PurchaseHistoryTable extends Table {
    public function initialize(array $config): void {
        parent::initialize($config);

        $this->setTable('purchase_history'); // Nazwa tabeli w bazie danych
        $this->setDisplayField('product_name'); // Pole używane jako etykieta
        $this->setPrimaryKey('id'); // Klucz główny

        // Relacja z użytkownikiem (zakładając, że masz UsersTable)
        $this->belongsTo('Users', [
            'foreignKey' => 'user_id',
            'joinType' => 'INNER'
        ]);
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
            ->allowEmptyString('description')
            ->allowEmptyFile('image_url')
            ->add('image_url', 'validExtension', [
                'rule' => ['extension', ['jpg', 'png', 'gif']],
                'message' => 'Only image files with .jpg, .png, or .gif extensions are allowed',
            ])
            ->notEmptyString('user_id', 'User ID is required')
            ->integer('user_id', 'User ID must be an integer');

        return $validator;
    }
}
