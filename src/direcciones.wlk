import wollok.game.*

object norte {
	method esValida(pos) = pos.y() != 12
	
}

object sur {
	method esValida(pos) = pos.y() != 0
	
}

object este {
	method esValida(pos) = pos.x() != 12
	
}

object oeste {
	method esValida(pos) = pos.x() != 0
	
}

// posiciones 0 y 12 no deben ser caminadas
// position = game.at(1,2) donde 1=horizontal y 2=vertical