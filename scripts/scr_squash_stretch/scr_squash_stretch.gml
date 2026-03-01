//Efeito mola
function inicia_efeito_mola()
{
	//Iniciando as váriaveis que eu vou usar
	xscale = 1;
	yscale = 1;

}	

//Ele vai definir qual valor vai ter o meu "amassar"
function usa_efeito_mola(_xscale, _yscale)
{
	xscale = _xscale;
	yscale = _yscale;
	
}	

function etapa_efeito_mola(_qtd)
{
	xscale = lerp(xscale,1,_qtd);
	yscale = lerp(yscale,1,_qtd);
		
}	

function desenha_efeito_mola()
{
	draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,image_angle,image_blend,image_alpha);	
	
}	