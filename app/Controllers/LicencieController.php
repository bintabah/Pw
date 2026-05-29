<?php

class LicencieController {
    private $licencieDAO;

    public function __construct(LicencieDAO $licencieDAO) {
        $this->licencieDAO = $licencieDAO;
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
    public function index() {
        // Récupérer la liste de tous les licenciés depuis le modèle
        $this->checkAuthentication();
        $licencies = $this->licencieDAO->listLicencies();

        // Inclure la vue pour afficher la liste des licenciés
        include('../Views/licencie/licencieListe.php');
    }
    public function exportCSV() {
        $this->licencieDAO->exportLicenciesToCSV();
    }

    public function importCSV() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['csvFile'])) {
            $csvFile = $_FILES['csvFile']['tmp_name'];

            // Vérifiez si le fichier a été correctement téléchargé
            if (empty($csvFile) || !file_exists($csvFile)) {
                $_SESSION['import_message'] = "Erreur lors du téléchargement du fichier CSV.";
                header("Location: LicencieController.php"); // Redirigez vers la page principale ou une autre page en cas d'erreur
                exit();
            }

            // Appeler la fonction d'importation
            $success = $this->licencieDAO->importLicenciesFromCSV($csvFile);

            if ($success) {
                $_SESSION['import_message'] = "Licenciés importés avec succès";
            } else {
                $_SESSION['import_message'] = "Échec de l'importation.";
            }

            // Redirigez ou effectuez d'autres actions si nécessaire
            header("Location: LicencieController.php"); // Remplacez ceci par l'URL souhaitée
            exit();
        } else {
            // Gérer le cas où le formulaire n'est pas soumis correctement
            $_SESSION['import_message'] = "Formulaire non soumis correctement.";
            header("Location: LicencieController.php"); // Redirigez vers la page principale ou une autre page en cas d'erreur
            exit();
        }
    }



}

require_once("../../config/database.php");
require_once("../Models/Connexion.php");
require_once("../Models/Contact.php"); // Assurez-vous que la classe Contact est incluse si utilisée dans la classe Licencie
require_once("../Models/Categorie.php"); // Assurez-vous que la classe Categorie est incluse si utilisée dans la classe Licencie
require_once("../Models/Licencie.php");
require_once("../DAO/ContactDAO.php");
require_once("../DAO/CategorieDAO.php");
require_once("../DAO/LicencieDAO.php");
$licencieDAO = new LicencieDAO(new Connexion());
$controller = new LicencieController($licencieDAO);
$controller->index();
if ( isset($_GET['action']) && $_GET['action'] === 'exportCSV') {
    $controller->exportCSV();
}
if ( isset($_GET['action']) && $_GET['action'] === 'importCSV') {

    $controller->importCSV();
}

// Dans le contrôleur LicencieController

// Dans LicencieController.php




