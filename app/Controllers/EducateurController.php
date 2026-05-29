<?php

class EducateurController
{
    private $educateurDAO;

    public function __construct(EducateurDAO $educateurDAO)
    {
        $this->educateurDAO = $educateurDAO;
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
        // Récupérer la liste de tous les éducateurs depuis le modèle
        $educateurs = $this->educateurDAO->listEducateurs();

        // Inclure la vue pour afficher la liste des éducateurs
        include('../Views/educateur/educateurListe.php');
    }
}

// Initialiser les DAO et le contrôleur
require_once("../../config/database.php");
require_once("../Models/Connexion.php");
require_once("../Models/Educateur.php");
require_once("../DAO/EducateurDAO.php");

$educateurDAO = new EducateurDAO(new Connexion());
$controller = new EducateurController($educateurDAO);
$controller->index();
