if ( isAnimated ) {
	animIndex += animSpd * delta;
}

//// Move to a different solidPushable class or object...
// var _instance = user().GetController();
// var _pushSpeed = 0.5;

// if ( isPushable
// && IsColliding( _instance ) ) {
// 	pushTime = max( 0, pushTime - 1 );
	
// 	if ( pushTime <= 0 ) {
// 		if ( !isBeingPushed ) {
// 			pushDirection = user().GetUserMoveDirection();
// 			isBeingPushed = true;
// 		}
		
// 		transform.position.x += dcos( pushDirection ) * _pushSpeed;
// 		transform.position.y -= dsin( pushDirection ) * _pushSpeed;		
// 		_instance.transform.position.x += dcos( pushDirection ) * _pushSpeed;
// 		_instance.transform.position.y -= dsin( pushDirection ) * _pushSpeed;
		
// 		pushCooldown = max( 0, pushCooldown - 1 );
// 	}
// 	if ( pushCooldown <= 0 ) {
// 		isBeingPushed  = false;
		
// 		pushTime = 60;
// 		pushCooldown = 30;
// 	}
// }
// else {
// 	isBeingPushed  = false;
// 	pushTime = 60 * 2;
// 	pushCooldown = 30;
// 	return;
// }