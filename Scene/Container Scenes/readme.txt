Container Scene

Itong scene ay ang root scene ng lahat ng "container" scene natin.

Components:
	
	ROOT NODE: Area2d                                             (nag dedetect lang ito if may napasok sa area nio or na exit)
		child ni Area2d: CollisionShape2D                         (ito lang yung shape or yung area gaano kalaki yung area na ma dedetect) 
		child ni Area2d: Panel                                    (panel basically UI lang to na container naman ng labels or button [coded ngayun na lalabas to pag may pumasok])
			child ni Panel: Label                                 (text dito kalang mag tatype kung anong text)
			child ni Panel: MenuButton                            (Button lang yan pwede mapindot)
		child ni Area2d: Panel2                                   (lalabas to pag pinindut yung isang "buy" button sa Panel)
			child ni Panel2:                                      (Button (same lang din ni MenuButton pag pinindot kung sino man ung na dedetect ng area makaka recieve ng rice)
		child ni Area2d: CharacterBody2D                          (Para to sa mga object na may physical body na nagalaw palano ko kasing gawing character yung nag titinda)
			child ni CharacterBody2D: Sprite2D                    (container ng Pixel art na di need ng animation)        
			child ni CharacterBody2D: CollisionPolygon2D          (collision ng character mo para di tumagas sa mga object na may collision din)
