import wollok.game.*
import objetos.*

object mapa {
	var property posProhibidas = []

	method hayObstaculo(pos) = posProhibidas.any({o => o.position() == pos})
	
	method agregarPosiciones() {
		posProhibidas.add(new Obstaculo(position=game.at(5,2)))
		posProhibidas.add(new Obstaculo(position=game.at(7,4)))
		posProhibidas.add(new Obstaculo(position=game.at(2,6)))
		posProhibidas.add(new Obstaculo(position=game.at(8,8)))
		posProhibidas.add(new Obstaculo(position=game.at(11,5)))
	}
}
