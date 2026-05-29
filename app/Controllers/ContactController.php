<?php
class ContactController {
    private $contactDAO;

    public function __construct(ContactDAO $contactDAO) {
        $this->contactDAO = $contactDAO;
    }
    private function checkAuthentication() {
        // Vérifier si l'utilisateur est authentifié en tant qu'administrateur
        session_start();
        if (!isset($_SESSION['email'])) {
            // Rediriger vers la page de connexion si non authentifié
            header('Location: ../../index.php');
            exit();
        }
    }
    public function index()
    {
        $this->checkAuthentication();
        // RÃ©cupÃ©rer la liste de tous les contacts depuis le modÃ¨le
        $contacts = $this->contactDAO->listContacts();

        // Inclure la vue pour afficher la liste des contacts
        include('../Views/contact/contactListe.php');
    }
}

require_once("../../config/database.php");
require_once("../Models/Connexion.php");
require_once("../Models/Contact.php");
require_once("../DAO/ContactDAO.php");
$contactDAO=new ContactDAO(new Connexion());
$controller=new ContactController($contactDAO);
$controller->index();

?>
