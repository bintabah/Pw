<?php
class CategorieController {
    private $categorieDAO;

    public function __construct(CategorieDAO $categorieDAO) {
        $this->categorieDAO = $categorieDAO;
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
        $categories = $this->categorieDAO->listCategories();

        // Inclure la vue pour afficher la liste des contacts
        include('../Views/categorie/categorieliste.php');
    }
}

require_once("../../config/database.php");
require_once("../Models/Connexion.php");
require_once("../Models/Categorie.php");
require_once("../DAO/CategorieDAO.php");

$categorieDAO=new CategorieDAO(new Connexion());
$controller=new CategorieController($categorieDAO);
$controller->index();

?>
