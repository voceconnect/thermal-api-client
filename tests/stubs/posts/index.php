<?php
header('Content-Type: application/json');
if (isset($_GET['paged']) && $_GET['paged'] === '2') {
	require('page2.json');
} else {
	require('page1.json');

}