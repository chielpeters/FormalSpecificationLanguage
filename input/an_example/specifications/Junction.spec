import TrafficLight

Specification Junction

Fields{
	left : TrafficLight
	right : TrafficLight
}

Events{
	init()
	changeJunctionState()
}

Invariants{
	No2GreenLights
}