if (global.ui_bloqueada) exit;

image_index = 2;

if (layer_exists("TutorialCombate")) 
    {
        
        layer_destroy("TutorialCombate");
        
    }

var _destino = room;
cria_transicao_inicia(_destino);


