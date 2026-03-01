if (!se_destroi) exit;

image_alpha = lerp(image_alpha,0,.2);

if(image_alpha <= 0.1)
{
    instance_destroy();
}



