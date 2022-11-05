import wollok.game.*
import personajes.*

import numeros.*


object juego {
	var juegoIniciado = false
	method iniciar() {
		game.title("fire fighters")
		game.width(13)
		game.height(13)	
		mapa.agregarPosiciones()

		game.boardGround("fondo.png")
		game.addVisualIn(pantallaDeInicio,game.at(0,0))
		pantallaDeInicio.iniciarAnimacion()
		keyboard.enter().onPressDo({self.empezar()})  
		
		game.start()
	}
	
	method bomberoControles(){
		keyboard.up().onPressDo({bombero.subir()})
		keyboard.down().onPressDo({bombero.bajar()})
		keyboard.left().onPressDo({bombero.izquierda()})
		keyboard.right().onPressDo({bombero.derecha()})
		keyboard.space().onPressDo({bombero.lanzarAgua()})
		
		game.addVisual(bombero)
		
	}
	
	method empezar(){
		
	
	
		
		game.sound("comienzo.mp3")
		if (not juegoIniciado){
			game.removeVisual(pantallaDeInicio)
			juegoIniciado = true
			self.bomberoControles()
			pantallaDeInicio.terminarAnimacion()
		game.addVisual(time)
		game.addVisual(puntaje)
		game.schedule(2000,{game.onTick(1000,"tiempo",{reloj.disminuir()})})
		new Fuego().aparecer()
		game.onCollideDo(bombero,{f=>bombero.sumarPuntaje() })
		game.onCollideDo(bombero,{f=>game.removeVisual(f) })
		//game.onCollideDo(
	   
		}
		
	}
	
	method forzarDesaparicionEn(pos){
		game.getObjectsIn(pos).forEach{unObjeto=>unObjeto.forzarDesaparicion()}
	}

}


object mapa{
	var posProhibidas = []

	method esUnaPared(pos) = posProhibidas.contains(pos)
	
	method agregarPosiciones(){
		11.times{k=>
			posProhibidas.add(game.at(k,0))
			posProhibidas.add(game.at(k,12))
			posProhibidas.add(game.at(0,k))
			posProhibidas.add(game.at(12,k))			
		}
	}
	
}


object pantallaDeInicio{
	var imagen = false
	method iniciarAnimacion(){
		game.onTick(250,"Animacion del menu",{self.cambiar()})
	}
	method terminarAnimacion(){
		game.removeTickEvent("Animacion del menu")
	}
	method cambiar(){
		if(imagen)
			imagen = false
		else
			imagen = true
	}
	
	method image() {
		if(imagen)
			return "inicio.jpg"
		else
			return "inicio1.jpg"
	}
}
class Agua{
	var property image="agua.png"
	var property position=bombero.position().right(1)
}
