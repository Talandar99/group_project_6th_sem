<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class UsersTable extends Table
{
    public function initialize(array $config): void
    {
        parent::initialize($config);

        $this->setTable('users');
        $this->setDisplayField('email');
        $this->setPrimaryKey('id');
    }

    public function validationDefault(Validator $validator): Validator
    {
        $validator
            ->email('email', false, 'Podaj poprawny adres e-mail.')
            ->requirePresence('email', 'create', 'Adres e-mail jest wymagany.')
            ->notEmptyString('email', 'Adres e-mail nie może być pusty.');

        $validator
            ->scalar('password')
            ->minLength('password', 8, 'Hasło musi mieć co najmniej 8 znaków.')
            ->requirePresence('password', 'create', 'Hasło jest wymagane.')
            ->notEmptyString('password', 'Hasło nie może być puste.');

        return $validator;
    }
}
