//Me desenhando
if(global.transicao) return;
    
draw_self();

//Desenhando meu brilho
//Variando a escala do brilho
var _esc = random_range(0,0.01);

gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_brilho_cajado,0,x,y,0.15 + _esc,0.15 + _esc,0,c_white,0.2);
gpu_set_blendmode(bm_normal);