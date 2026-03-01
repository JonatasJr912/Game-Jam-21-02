depth = -y + 10;

// Se mundo mudou, troca forma e verifica queda imediata
if (mundo_anterior != global.mundo)
{
    mundo_anterior = global.mundo;

    atualiza_forma();
    checa_morte_skeleton();
}

estado();

show_debug_message(image_xscale);

//show_debug_overlay(true);
