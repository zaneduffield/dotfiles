#SingleInstance force
; remove "-" from the EndChars
#Hotstring EndChars ()[]{}:;'"/\,.?!`n `t

; ## This section replaces three hyphens "---" with an em dash "—" ##
; ? makes it so the hotstring will activate even in the middle of a word
:?:---::—

; ## This section replaces four hyphens "----" with an en dash "–" ##
; ? makes it so the hotstring will activate even in the middle of a word
:?:----::–