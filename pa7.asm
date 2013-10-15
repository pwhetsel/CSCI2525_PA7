;TITLE: PA7				(pa7.asm)
;
; Author: Patrick Whetsel
; Creation Date: 4/21/13
;
; Program Description: This program prompts the user for the number of human players in a game in tic-tac-toe and proceeds to play the game,
;					   adding computer players as neccesary.


INCLUDE pa7functions.inc

.data

;game over annotations
x_wins BYTE "Player X is the winner!",0
o_wins BYTE "Player O is the winner!",0
tie_msg BYTE "The game is a tie!",0
game_over BYTE "GAME OVER!!!",0

;variable to store number of human players
human_players DWORD ?

;number of players prompt
players_prompt BYTE "Please enter the number of human players (0-2): ", 0


.code
main PROC

call Randomize																	;seed rng for computer player moves

;invoke procedure to prompt user for number of human players in game, stored in human_players
invoke player_prompt, addr players_prompt, addr human_players

;turn_1:
	;print board and key
	invoke print_board
player_X1:	
	mov eax, human_players														;determine if human or computer player for X
	cmp eax,0
	je comp_player_x1
	cmp eax,0
	ja hum_player_x1
	
	comp_player_x1:																;computer player X takes turn
		invoke comp_turn_x
		jmp player_O1
	hum_player_x1:																;human player X takes turn
		invoke hum_turn_x
		jmp player_O1
player_O1:
	;print board and key
	invoke print_board
	mov eax, human_players														;determine if human or computer player for O
	cmp eax,2
	jb comp_player_o1
	cmp eax,2
	je hum_player_o1
	
	comp_player_o1:																;computer player O takes turn
		invoke comp_turn_o
		jmp end_turn_1
	hum_player_o1:																;human player O takes turn
		invoke hum_turn_o
		jmp end_turn_1
end_turn_1:
	;print board and key
	invoke print_board
	jmp turn_2


turn_2:
	;print board and key
	invoke print_board
;player_X2:	
	mov eax, human_players														;determine if human or computer player for X
	cmp eax,0
	je comp_player_x2
	cmp eax,0
	ja hum_player_x2
	
	comp_player_x2:																;computer player X takes turn
		invoke comp_turn_x
		jmp player_O2
	hum_player_x2:																;human player X takes turn
		invoke hum_turn_x
		jmp player_O2
player_O2:
	;print board and key
	invoke print_board
	mov eax, human_players														;determine if human or computer player for O
	cmp eax,2
	jb comp_player_o2
	cmp eax,2
	je hum_player_o2
	
	comp_player_o2:																;computer player O takes turn
		invoke comp_turn_o
		jmp end_turn_2
	hum_player_o2:																;human player O takes turn
		invoke hum_turn_o
		jmp end_turn_2
end_turn_2:
	;print board and key
	invoke print_board
	jmp turn_3																	
	
turn_3:
	;print board and key
	invoke print_board
;player_X3:	
	mov eax, human_players														;determine if human or computer player for X
	cmp eax,0
	je comp_player_x3
	cmp eax,0
	ja hum_player_x3
	
	comp_player_x3:																;computer player X takes turn
		invoke comp_turn_x
		invoke check_win_x														;check if player x won, this is the first turn this is possible
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O3
	hum_player_x3:																;human player X takes turn
		invoke hum_turn_x
		invoke check_win_x														;check if player x won, this is the first turn this is possible
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O3
player_O3:
	;print board and key
	invoke print_board
	mov eax, human_players														;determine if human or computer player for O
	cmp eax,2
	jb comp_player_o3
	cmp eax,2
	je hum_player_o3
	
	comp_player_o3:																;computer player O takes turn
		invoke comp_turn_o
		invoke check_win_o														;check if player O won, this is the first turn this is possible
		cmp eax,'y'
		je winner_o																;if player O has won jump to winning message
		jmp end_turn_3
	hum_player_o3:																;human player O takes turn
		invoke hum_turn_o
		invoke check_win_o														;check if player O won, this is the first turn this is possible
		cmp eax,'y'
		je winner_o																;if player O has won jump to winning message
		jmp end_turn_3
end_turn_3:
	;print board and key
	invoke print_board
	jmp turn_4	

turn_4:
	;print board and key
	invoke print_board
;player_X4:	
	mov eax, human_players														;determine if human or computer player for X
	cmp eax,0
	je comp_player_x4
	cmp eax,0
	ja hum_player_x4
	
	comp_player_x4:																;computer player X takes turn
		invoke comp_turn_x
		invoke check_win_x														;check if player x won
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O4
	hum_player_x4:																;human player X takes turn
		invoke hum_turn_x
		invoke check_win_x														;check if player x won
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O4
player_O4:
	;print board and key
	invoke print_board
	mov eax, human_players														;determine if human or computer player for O
	cmp eax,2
	jb comp_player_o4
	cmp eax,2
	je hum_player_o4
	
	comp_player_o4:																;computer player O takes turn
		invoke comp_turn_o
		invoke check_win_o														;check if player O won
		cmp eax,'y'
		je winner_o																;if player O has won jump to winning message
		jmp end_turn_4
	hum_player_o4:																;human player O takes turn
		invoke hum_turn_o
		invoke check_win_o														;check if player O won
		cmp eax,'y'
		je winner_o																;if player O has won jump to winning message
		jmp end_turn_4
end_turn_4:
	;print board and key
	invoke print_board
	jmp turn_5	

turn_5:
	;print board and key
	invoke print_board
;player_X5:	
	mov eax, human_players														;determine if human or computer player for X
	cmp eax,0
	je comp_player_x5
	cmp eax,0
	ja hum_player_x5
	
	comp_player_x5:																;computer player X takes turn
		invoke comp_turn_x
		invoke check_win_x														;check if player x won
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O5
	hum_player_x5:																;human player X takes turn
		invoke hum_turn_x
		invoke check_win_x														;check if player x won
		cmp eax,'y'
		je winner_x																;if player x has won jump to winning message
		jmp player_O5
player_O5:																		;player O does not have a fifth turn, the game is a tie
	;print board and key
	invoke print_board
	jmp tie																		;no more open spots on board, go to tie message

winner_x:																		;declare player x the winner
	;print board and key
	invoke print_board
	mov edx, offset x_wins
	call crlf
	call WriteString
	call crlf
	jmp end_game
winner_o:																		;declare player o the winner
	;print board and key
	invoke print_board															
	mov edx, offset o_wins
	call crlf
	call WriteString
	call crlf
	jmp end_game	
tie:																			;declare the game a tie
	mov edx, offset tie_msg
	call crlf
	call WriteString
	call crlf
	jmp end_game
end_game:
	mov edx, offset game_over
	call WriteString
	call crlf
	call Waitmsg

exit
main ENDP
END main