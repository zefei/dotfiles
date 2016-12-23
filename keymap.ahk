#MaxHotkeysPerInterval 200

!a::SendInput ^a
!c::SendInput ^c
!f::SendInput ^f
!k::SendInput ^k
!l::SendInput ^l
!n::SendInput ^n
!+n::SendInput ^+n
!q::SendInput !{F4}
!r::SendInput ^r
!s::SendInput ^s
!t::SendInput ^t
!+t::SendInput ^+t
!v::SendInput ^v
!w::SendInput ^w
!+w::SendInput ^+w
!x::SendInput ^x
!z::SendInput ^z
!+z::SendInput ^y
!1::SendInput ^1
!2::SendInput ^2
!3::SendInput ^3
!4::SendInput ^4
!5::SendInput ^5
!6::SendInput ^6
!7::SendInput ^7
!8::SendInput ^8
!9::SendInput ^9
!0::SendInput ^0
!Enter::SendInput ^{Enter}
!LButton::SendInput ^{LButton}
#F7::SendInput {Media_Prev}
#F8::SendInput {Media_Play_Pause}
#F9::SendInput {Media_Next}
#F10::SendInput {Volume_Mute}
#F11::SendInput {Volume_Down}
#F12::SendInput {Volume_Up}


#IfWinActive StreetFighterV
e::w ; Up
d::s ; Down
s::a ; Left
f::d ; Right
u::g ; LP
i::h ; MP
o::j ; HP
y::k ; LP+MP+HP
j::b ; LK
k::n ; MK
l::m ; HK
h::, ; LK+MK+HK
m:: ; Throw
SendInput {g down}{b down}
KeyWait, m
SendInput {g up}{b up}
Return
,:: ; V-Skill
SendInput {h down}{n down}
KeyWait, `,
SendInput {h up}{n up}
Return
.:: ; V-Trigger
SendInput {j down}{m down}
KeyWait, .
SendInput {j up}{m up}
Return
Return
