if (!acabou) {
    chars += vel;

    var total = string_length(texto);
    if (chars >= total) {
        chars = total;
        acabou = true;
    }
}
