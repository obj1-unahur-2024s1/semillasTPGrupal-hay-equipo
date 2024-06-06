class Planta {
	const anioDeSemilla
	var altura
	//var cuantoEspacioOcupa
	method horasDeSol() // metodo abstracto
	method esFuerte(){return self.horasDeSol() > 10}
	
	method daSemillas(){
		return self.esFuerte() or self.condicionAlternativa()
	}
	method condicionAlternativa() // metodo abstracto
}

class Menta inherits Planta{
	override method horasDeSol(){return 6}
	override method condicionAlternativa(){return altura > 0.4}
	method cuantoEspacioOcupa(){return altura * 3}
}

class Soja inherits Planta{
	override method horasDeSol(){
		return if(altura < 0.5){6} else if(0.5<altura and altura <1){7} else{9}
	}
	override method condicionAlternativa(){return anioDeSemilla > 2007 and altura > 1}
	method cuantoEspacioOcupa(){return altura / 2}
}

class Quinoa inherits Planta{
	var horasDeSol
	override method horasDeSol(){return horasDeSol}
	override method condicionAlternativa(){return anioDeSemilla < 2005}
}