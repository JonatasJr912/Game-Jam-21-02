//Usamos para iniciar as váriaveis do efeito de brilho no Create.
function inicia_efeito_brilho()
{
    //Definindo as escalas
    xscale = 1;
    yscale = 1;
    dir    = 1;
    
    //Definindo as variáveis de cor do brilho
    cor_brilho   = c_white;
    alpha_brilho = 0; 

} 

//Usamos no "método de ação" para usar o efeito de brilho, podemos alterar a cor
function usa_efeito_brilho(_cor = c_white,_alpha = 1)
{
    cor_brilho = _cor;
    alpha_brilho = _alpha;
    
}

//Usamos para retornar sempre a cor original no Step.
function etapa_efeito_brilho(_vel = 0.1)
{
    alpha_brilho = lerp(alpha_brilho,0,_vel);
    
}

//Usamos no draw para desenhar o objeto com as váriaveis que vamos alterar, sempre DEPOIS de desenhar a sprite.
function desenha_efeito_brilho()
{
    //Só preciso me desenhar se o alpha brilho for maior do que zero
    if(alpha_brilho <= 0.01) return;
    
    shader_set(sh_efeito_brilho);
    draw_sprite_ext(sprite_index,image_index,x,y,xscale * dir,yscale,image_angle,cor_brilho,alpha_brilho);
    shader_reset();
    
}




