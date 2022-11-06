import wollok.game.*

object norte {
	method esValida(pos) = pos.y() != 12
	method imageAgua() = "aguaVertical.png"
	method aguaPosition(pos) = pos.up(1)
	method imageBombero() = "bomberoNorte.png"
	
}

object sur {
	method esValida(pos) = pos.y() != 0
	method imageAgua() = "aguaVertical.png"
	method aguaPosition(pos) = pos.down(1)
	method imageBombero() = "bomberoSur.png"
	
}

object este {
	method esValida(pos) = pos.x() != 12
	method imageAgua() = "aguaHorizontal.png"
	method aguaPosition(pos) = pos.right(1)
	method imageBombero() = "bomberoEste.png"
	
}

object oeste {
	method esValida(pos) = pos.x() != 0
	method imageAgua() = "aguaHorizontal.png"
	method aguaPosition(pos) = pos.left(1)
	method imageBombero() = "bomberoOeste.png"
	
}

// posiciones 0 y 12 no deben ser caminadas
// position = game.at(1,2) donde 1=horizontal y 2=vertical