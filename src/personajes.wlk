import wollok.game.*
import mapa.*

object bombero {
	var property image = "bombero2.png"
	var property position = game.origin()
	var cantVentanasApagadas
	var property jugadorVaGanando = true
	
	method moverse(pos){ position = pos }
	method apagarVentana(){ 
		if(mapa.ventanaEstaQuemada(position)) {
			mapa.ventana(position).apagarse()
  			cantVentanasApagadas += 1
		}
	}
	method subir(){self.moverse(position.up(1))}
	method bajar(){self.moverse(position.down(1))}
	method izquierda(){
		self.moverse(position.left(1))
	}
	method derecha(){
		self.moverse(position.right(1))
	}
}

object rival {
	var property image = "enemigo.png"
	var property position = game.at(1, 2)
	var property cantidadVentanasQuemadas 
	
//	method movete() {
//   	const x = 3.randomUpTo(6).truncate(0)
//   	const y = 0.randomUpTo(4).truncate(0)
//    	position = game.at(x,y) 
 // }
  
  method quemarVentana() {
  	if(mapa.hayVentana(position)) { 
  		mapa.ventana(position).quemarse()
  		cantidadVentanasQuemadas += 1
  	}
  		
  }
}