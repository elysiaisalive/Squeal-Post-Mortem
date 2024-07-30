scale += 0.0010 * delta;
alpha -= 0.0020 * delta;

if ( ( scale >= 2.50 ) || ( alpha <= 0 ) )
{
    instance_destroy();
};