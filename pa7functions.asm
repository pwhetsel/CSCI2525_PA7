;TITLE: PA7				(pa7functions.asm)
;
; Author: Patrick Whetsel
; Creation Date: 4/21/13
;
; Program Description: This program prompts the user for the number of human players in a game in tic-tac-toe and proceeds to play the game,
;					   adding computer players as neccesary.

INCLUDE pa7functions.inc

.data

THREE_XS equ 264																	ASCII value of 3*X
THREE_OS equ 237																	ASCII value of 3*O

;human player move
human_move DWORD ?

;human player prompts
human_x_prompt BYTE "Player X enter the value 0-8 where you would like to play:",0
human_o_prompt BYTE "Player O enter the value 0-8 where you would like to play:",0

;computer player annotations
comp_x_turn BYTE "Computer Player X takes its turn!",0
comp_o_turn BYTE "Computer Player O takes its turn!",0

;array and title for holding values in game grid
board_row_1 BYTE "BOARD", 0
board BYTE 9 DUP(' ')

;Key board strings
key_row_1 BYTE " KEY ", 0
key_row_2 BYTE "0|1|2", 0
key_row_3 BYTE "3|4|5", 0
key_row_4 BYTE "6|7|8", 0

.code

;procedure to prompt user for and store number of human players in game
player_prompt PROC, player_prompt_ptr:PTR byte, human_players_ptr:PTR byte
mov edx,player_prompt_ptr
prompt:
	call WriteString																	;write prompt to screen
	call crlf
	call ReadDec
check:																					;confirm value is [0,2]
	cmp eax,2
	ja prompt
	cmp eax,0
	jb prompt
	jmp store
store:
	mov ebx,human_players_ptr
	mov [ebx],eax																		;store number of human players
ret
player_prompt ENDP

;procedure to write current board to screen along with key for input
print_board PROC

call Clrscr
mov edx, offset board_row_1
call WriteString	
call crlf																			;write board label
mov esi, offset board

mov al, [esi]
call WriteChar																		;board 0
mov al, '|'
call writeChar

mov al, [esi+1]
call WriteChar																		;board 1
mov al, '|'
call writeChar

mov al, [esi+2]
call WriteChar																		;board 2

call crlf																			;next row

mov al, [esi+3]
call WriteChar																		;board 3
mov al, '|'
call writeChar

mov al, [esi+4]
call WriteChar																		;board 4
mov al, '|'
call writeChar

mov al, [esi+5]
call WriteChar																		;board 5


call crlf																			;next row

mov al, [esi+6]
call WriteChar																		;board 6
mov al, '|'
call writeChar

mov al, [esi+7]
call WriteChar																		;board 7
mov al, '|'
call writeChar

mov al, [esi+8]
call WriteChar																		;board 8

;draw key to right of board
mov dh,0
mov dl,15
call gotoxy
mov edx, offset key_row_1															;print key row 1
call WriteString

mov dh,1
mov dl,15
call gotoxy
mov edx, offset key_row_2															;print key row 2
call WriteString

mov dh,2
mov dl,15
call gotoxy
mov edx, offset key_row_3															;print key row 3
call WriteString

mov dh,3
mov dl,15
call gotoxy
mov edx, offset key_row_4															;print key row 4
call WriteString

mov dh,5
mov dl,0
call gotoxy

ret
print_board ENDP

;procedure for computer to take turn for player X, tries to win,block,play randomly
comp_turn_x PROC
mov edx, offset comp_x_turn
call WriteString																			;write annotation for computer player x turn
call crlf
call WaitMsg																				;hold for human input for computer to take turn
;computer player attempts to win
mov esi, offset board

;check row 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if row one has two x's in a row
je play_r1
jmp row2
play_r1:																				;if win is possible make winning move
	check1_1:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_1
		jmp check2_1
	write1_1:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_1:																				;check and write if second spot open
		mov al, [esi+1]
		cmp al,' '
		je write2_1
		jmp write3_1
	write2_1:
		mov al, 'X'
		mov [esi+1],al
		jmp return
	write3_1:																				;write in open third spot
		mov al,'X'
		mov [esi+2],al
		jmp return
row2:
;check row 2 for two x;x
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if row two has two x's in a row
je play_r2
jmp row3
play_r2:																				;if win is possible make winning move
	check1_2:																				;check and write if first spot is open
		mov al, [esi+3]
		cmp al,' '
		je write1_2
		jmp check2_2
	write1_2:
		mov al,'X'
		mov [esi+3],al
		jmp return
	check2_2:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_2
		jmp write3_2
	write2_2:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_2:																				;write in open third spot
		mov al,'X'
		mov [esi+5],al
		jmp return
row3:
;check row 3 for two x's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208	
je play_r3																				;check if row three has two x's in a row
jmp column1
play_r3:																				;if win is possible make winning move
	check1_3:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_3
		jmp check2_3
	write1_3:
		mov al,'X'
		mov [esi+6],al
		jmp return
	check2_3:																				;check and write if second spot open
		mov al, [esi+7]
		cmp al,' '
		je write2_3
		jmp write3_3
	write2_3:
		mov al, 'X'
		mov [esi+7],al
		jmp return
	write3_3:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
column1:
;check column 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if column one has two x's in a row
je play_c1																				;check if row three has two x's in a row
jmp column2
play_c1:																				;if win is possible make winning move
	check1_4:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_4
		jmp check2_4
	write1_4:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_4:																				;check and write if second spot open
		mov al, [esi+3]
		cmp al,' '
		je write2_4
		jmp write3_4
	write2_4:
		mov al, 'X'
		mov [esi+3],al
		jmp return
	write3_4:																				;write in open third spot
		mov al,'X'
		mov [esi+6],al
		jmp return
column2:
;check column 2 for two x's
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if column two has two x's in a row
je play_c2																				;check if row three has two x's in a row
jmp column3
play_c2:																				;if win is possible make winning move
	check1_5:																				;check and write if first spot is open
		mov al, [esi+1]
		cmp al,' '
		je write1_5
		jmp check2_5
	write1_5:
		mov al,'X'
		mov [esi+1],al
		jmp return
	check2_5:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_5
		jmp write3_5
	write2_5:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_5:																				;write in open third spot
		mov al,'X'
		mov [esi+7],al
		jmp return
column3:
;check column 3 for two x's
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if column three has two x's in a row
je play_c3																				;check if row three has two x's in a row
jmp diag1
play_c3:																				;if win is possible make winning move
	check1_6:																				;check and write if first spot is open
		mov al, [esi+2]
		cmp al,' '
		je write1_6
		jmp check2_6
	write1_6:
		mov al,'X'
		mov [esi+2],al
		jmp return
	check2_6:																				;check and write if second spot open
		mov al, [esi+5]
		cmp al,' '
		je write2_6
		jmp write3_6
	write2_6:
		mov al, 'X'
		mov [esi+5],al
		jmp return
	write3_6:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
diag1:
;check diag 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if diag one has two x's in a row
je play_d1																				;check if row three has two x's in a row
jmp diag2
play_d1:																				;if win is possible make winning move
	check1_7:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_7
		jmp check2_7
	write1_7:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_7:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_7
		jmp write3_7
	write2_7:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_7:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
diag2:
;check diag 2 for two x's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if diag two has two x's in a row
je play_d2																				;check if row three has two x's in a row
jmp block
play_d2:																				;if win is possible make winning move
	check1_8:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_8
		jmp check2_8
	write1_8:
		mov al,'X'
		mov [esi+6],al
		jmp return
	check2_8:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_8
		jmp write3_8
	write2_8:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_8:																				;write in open third spot
		mov al,'X'
		mov [esi+2],al
		jmp return
;computer player attempts to block
block:
mov esi, offset board

;check row 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if row one has two o's in a row
je play_r1o
jmp row2o
play_r1o:																				;if win is possible make winning move
	check1_9:																			;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_9
		jmp check2_9
	write1_9:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_9:																				;check and write if second spot open
		mov al, [esi+1]
		cmp al,' '
		je write2_9
		jmp write3_9
	write2_9:
		mov al, 'X'
		mov [esi+1],al
		jmp return
	write3_9:																				;write in open third spot
		mov al,'X'
		mov [esi+2],al
		jmp return
row2o:
;check row 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if row two has two x's in a row
je play_r2o
jmp row3o
play_r2o:																				;if win is possible make winning move
	check1_10:																				;check and write if first spot is open
		mov al, [esi+3]
		cmp al,' '
		je write1_10
		jmp check2_10
	write1_10:
		mov al,'X'
		mov [esi+3],al
		jmp return
	check2_10:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_10
		jmp write3_10
	write2_10:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_10:																				;write in open third spot
		mov al,'X'
		mov [esi+5],al
		jmp return
row3o:
;check row 3 for two o's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190	
je play_r3o																				;check if row three has two x's in a row
jmp column1o
play_r3o:																				;if win is possible make winning move
	check1_11:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_11
		jmp check2_11
	write1_11:
		mov al,'X'
		mov [esi+6],al
		jmp return
	check2_11:																				;check and write if second spot open
		mov al, [esi+7]
		cmp al,' '
		je write2_11
		jmp write3_11
	write2_11:
		mov al, 'X'
		mov [esi+7],al
		jmp return
	write3_11:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
column1o:
;check column 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if column one has two x's in a row
je play_c1o																				;check if row three has two x's in a row
jmp column2o
play_c1o:																				;if win is possible make winning move
	check1_12:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_12
		jmp check2_12
	write1_12:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_12:																				;check and write if second spot open
		mov al, [esi+3]
		cmp al,' '
		je write2_12
		jmp write3_12
	write2_12:
		mov al, 'X'
		mov [esi+3],al
		jmp return
	write3_12:																				;write in open third spot
		mov al,'X'
		mov [esi+6],al
		jmp return
column2o:
;check column 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if column two has two x's in a row
je play_c2o																				;check if row three has two x's in a row
jmp column3o
play_c2o:																				;if win is possible make winning move
	check1_13:																				;check and write if first spot is open
		mov al, [esi+1]
		cmp al,' '
		je write1_13
		jmp check2_13
	write1_13:
		mov al,'X'
		mov [esi+1],al
		jmp return
	check2_13:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_13
		jmp write3_13
	write2_13:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_13:																				;write in open third spot
		mov al,'X'
		mov [esi+7],al
		jmp return
column3o:
;check column 3 for two o's
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if column three has two x's in a row
je play_c3o																				;check if row three has two x's in a row
jmp diag1o
play_c3o:																				;if win is possible make winning move
	check1_14:																				;check and write if first spot is open
		mov al, [esi+2]
		cmp al,' '
		je write1_14
		jmp check2_14
	write1_14:
		mov al,'X'
		mov [esi+2],al
		jmp return
	check2_14:																				;check and write if second spot open
		mov al, [esi+5]
		cmp al,' '
		je write2_14
		jmp write3_14
	write2_14:
		mov al, 'X'
		mov [esi+5],al
		jmp return
	write3_14:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
diag1o:
;check diag 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if diag one has two x's in a row
je play_d1o																				;check if row three has two x's in a row
jmp diag2o
play_d1o:																				;if win is possible make winning move
	check1_15:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_15
		jmp check2_15
	write1_15:
		mov al,'X'
		mov [esi],al
		jmp return
	check2_15:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_15
		jmp write3_15
	write2_15:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_15:																				;write in open third spot
		mov al,'X'
		mov [esi+8],al
		jmp return
diag2o:
;check diag 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if diag two has two x's in a row
je play_d2o																				;check if row three has two x's in a row
jmp generate_move
play_d2o:																				;if win is possible make winning move
	check1_16:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_16
		jmp check2_16
	write1_16:
		mov al,'X'
		mov [esi+6],al
		jmp return
	check2_16:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_16
		jmp write3_16
	write2_16:
		mov al, 'X'
		mov [esi+4],al
		jmp return
	write3_16:																				;write in open third spot
		mov al,'X'
		mov [esi+2],al
		jmp return
;computer player plays in random open spot
generate_move:
	mov esi,offset board
	mov eax,9																				;n-1 for range [0,8]
	call RandomRange
	;debug

check_spot:
	add esi,eax
	mov dl,[esi]
	cmp dl,' '																			;see if generated spot is open
	je write_move
	jmp generate_move
write_move:
	mov al,'X'
	mov [esi],al
return:
ret
comp_turn_x ENDP

;procedure to prompt human to take turn for player X
hum_turn_x PROC
prompt:
	call crlf
	mov edx, offset human_x_prompt
	call WriteString																	;prompt user for move
	call crlf
	call ReadDec
	mov human_move, eax																	;store move
	mov esi, offset board
check_open:																				;confirm that user entered spot is open
	add esi, human_move
	mov al,[esi]
	cmp al, ' '
	je write																			;write if spot is open
	jmp prompt																			;prompt user for new spot otherwise
write:
	mov al, 'X'
	mov [esi], al																		;change cell selected by player to X
ret
hum_turn_x ENDP

;procedure for computer to take turn for player O, tries to win,block,play randomly
comp_turn_o PROC
mov edx, offset comp_o_turn
call WriteString																			;write annotation for computer player o turn
call crlf
call WaitMsg																				;hold for human input for computer to take turn
;computer player attempts to win
mov esi, offset board

;check row 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if row one has two o's in a row
je play_r1o
jmp row2o
play_r1o:																				;if win is possible make winning move
	check1_9:																			;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_9
		jmp check2_9
	write1_9:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_9:																				;check and write if second spot open
		mov al, [esi+1]
		cmp al,' '
		je write2_9
		jmp write3_9
	write2_9:
		mov al, 'O'
		mov [esi+1],al
		jmp return
	write3_9:																				;write in open third spot
		mov al,'O'
		mov [esi+2],al
		jmp return
row2o:
;check row 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if row two has two x's in a row
je play_r2o
jmp row3o
play_r2o:																				;if win is possible make winning move
	check1_10:																				;check and write if first spot is open
		mov al, [esi+3]
		cmp al,' '
		je write1_10
		jmp check2_10
	write1_10:
		mov al,'O'
		mov [esi+3],al
		jmp return
	check2_10:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_10
		jmp write3_10
	write2_10:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_10:																				;write in open third spot
		mov al,'O'
		mov [esi+5],al
		jmp return
row3o:
;check row 3 for two o's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190	
je play_r3o																				;check if row three has two x's in a row
jmp column1o
play_r3o:																				;if win is possible make winning move
	check1_11:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_11
		jmp check2_11
	write1_11:
		mov al,'O'
		mov [esi+6],al
		jmp return
	check2_11:																				;check and write if second spot open
		mov al, [esi+7]
		cmp al,' '
		je write2_11
		jmp write3_11
	write2_11:
		mov al, 'O'
		mov [esi+7],al
		jmp return
	write3_11:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
column1o:
;check column 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if column one has two x's in a row
je play_c1o																				;check if row three has two x's in a row
jmp column2o
play_c1o:																				;if win is possible make winning move
	check1_12:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_12
		jmp check2_12
	write1_12:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_12:																				;check and write if second spot open
		mov al, [esi+3]
		cmp al,' '
		je write2_12
		jmp write3_12
	write2_12:
		mov al, 'O'
		mov [esi+3],al
		jmp return
	write3_12:																				;write in open third spot
		mov al,'O'
		mov [esi+6],al
		jmp return
column2o:
;check column 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if column two has two x's in a row
je play_c2o																				;check if row three has two x's in a row
jmp column3o
play_c2o:																				;if win is possible make winning move
	check1_13:																				;check and write if first spot is open
		mov al, [esi+1]
		cmp al,' '
		je write1_13
		jmp check2_13
	write1_13:
		mov al,'O'
		mov [esi+1],al
		jmp return
	check2_13:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_13
		jmp write3_13
	write2_13:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_13:																				;write in open third spot
		mov al,'O'
		mov [esi+7],al
		jmp return
column3o:
;check column 3 for two o's
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if column three has two x's in a row
je play_c3o																				;check if row three has two x's in a row
jmp diag1o
play_c3o:																				;if win is possible make winning move
	check1_14:																				;check and write if first spot is open
		mov al, [esi+2]
		cmp al,' '
		je write1_14
		jmp check2_14
	write1_14:
		mov al,'O'
		mov [esi+2],al
		jmp return
	check2_14:																				;check and write if second spot open
		mov al, [esi+5]
		cmp al,' '
		je write2_14
		jmp write3_14
	write2_14:
		mov al, 'O'
		mov [esi+5],al
		jmp return
	write3_14:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
diag1o:
;check diag 1 for two o's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 190																				;check if diag one has two x's in a row
je play_d1o																				;check if row three has two x's in a row
jmp diag2o
play_d1o:																				;if win is possible make winning move
	check1_15:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_15
		jmp check2_15
	write1_15:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_15:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_15
		jmp write3_15
	write2_15:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_15:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
diag2o:
;check diag 2 for two o's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 190																			;check if diag two has two x's in a row
je play_d2o																				;check if row three has two x's in a row
jmp block
play_d2o:																				;if win is possible make winning move
	check1_16:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_16
		jmp check2_16
	write1_16:
		mov al,'O'
		mov [esi+6],al
		jmp return
	check2_16:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_16
		jmp write3_16
	write2_16:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_16:																				;write in open third spot
		mov al,'O'
		mov [esi+2],al
		jmp return
block:
;computer player attempts to block
mov esi, offset board
;check row 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if row one has two x's in a row
je play_r1
jmp row2
play_r1:																				;if win is possible make winning move
	check1_1:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_1
		jmp check2_1
	write1_1:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_1:																				;check and write if second spot open
		mov al, [esi+1]
		cmp al,' '
		je write2_1
		jmp write3_1
	write2_1:
		mov al, 'O'
		mov [esi+1],al
		jmp return
	write3_1:																				;write in open third spot
		mov al,'O'
		mov [esi+2],al
		jmp return
row2:
;check row 2 for two x;x
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if row two has two x's in a row
je play_r2
jmp row3
play_r2:																				;if win is possible make winning move
	check1_2:																				;check and write if first spot is open
		mov al, [esi+3]
		cmp al,' '
		je write1_2
		jmp check2_2
	write1_2:
		mov al,'O'
		mov [esi+3],al
		jmp return
	check2_2:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_2
		jmp write3_2
	write2_2:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_2:																				;write in open third spot
		mov al,'O'
		mov [esi+5],al
		jmp return
row3:
;check row 3 for two x's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208	
je play_r3																				;check if row three has two x's in a row
jmp column1
play_r3:																				;if win is possible make winning move
	check1_3:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_3
		jmp check2_3
	write1_3:
		mov al,'O'
		mov [esi+6],al
		jmp return
	check2_3:																				;check and write if second spot open
		mov al, [esi+7]
		cmp al,' '
		je write2_3
		jmp write3_3
	write2_3:
		mov al, 'O'
		mov [esi+7],al
		jmp return
	write3_3:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
column1:
;check column 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 208																				;check if column one has two x's in a row
je play_c1																				;check if row three has two x's in a row
jmp column2
play_c1:																				;if win is possible make winning move
	check1_4:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_4
		jmp check2_4
	write1_4:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_4:																				;check and write if second spot open
		mov al, [esi+3]
		cmp al,' '
		je write2_4
		jmp write3_4
	write2_4:
		mov al, 'O'
		mov [esi+3],al
		jmp return
	write3_4:																				;write in open third spot
		mov al,'O'
		mov [esi+6],al
		jmp return
column2:
;check column 2 for two x's
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if column two has two x's in a row
je play_c2																				;check if row three has two x's in a row
jmp column3
play_c2:																				;if win is possible make winning move
	check1_5:																				;check and write if first spot is open
		mov al, [esi+1]
		cmp al,' '
		je write1_5
		jmp check2_5
	write1_5:
		mov al,'O'
		mov [esi+1],al
		jmp return
	check2_5:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_5
		jmp write3_5
	write2_5:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_5:																				;write in open third spot
		mov al,'O'
		mov [esi+7],al
		jmp return
column3:
;check column 3 for two x's
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if column three has two x's in a row
je play_c3																				;check if row three has two x's in a row
jmp diag1
play_c3:																				;if win is possible make winning move
	check1_6:																				;check and write if first spot is open
		mov al, [esi+2]
		cmp al,' '
		je write1_6
		jmp check2_6
	write1_6:
		mov al,'O'
		mov [esi+2],al
		jmp return
	check2_6:																				;check and write if second spot open
		mov al, [esi+5]
		cmp al,' '
		je write2_6
		jmp write3_6
	write2_6:
		mov al, 'O'
		mov [esi+5],al
		jmp return
	write3_6:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
diag1:
;check diag 1 for two x's
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if diag one has two x's in a row
je play_d1																				;check if row three has two x's in a row
jmp diag2
play_d1:																				;if win is possible make winning move
	check1_7:																				;check and write if first spot is open
		mov al, [esi]
		cmp al,' '
		je write1_7
		jmp check2_7
	write1_7:
		mov al,'O'
		mov [esi],al
		jmp return
	check2_7:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_7
		jmp write3_7
	write2_7:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_7:																				;write in open third spot
		mov al,'O'
		mov [esi+8],al
		jmp return
diag2:
;check diag 2 for two x's
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 208																			;check if diag two has two x's in a row
je play_d2																				;check if row three has two x's in a row
jmp generate_move
play_d2:																				;if win is possible make winning move
	check1_8:																				;check and write if first spot is open
		mov al, [esi+6]
		cmp al,' '
		je write1_8
		jmp check2_8
	write1_8:
		mov al,'O'
		mov [esi+6],al
		jmp return
	check2_8:																				;check and write if second spot open
		mov al, [esi+4]
		cmp al,' '
		je write2_8
		jmp write3_8
	write2_8:
		mov al, 'O'
		mov [esi+4],al
		jmp return
	write3_8:																				;write in open third spot
		mov al,'O'
		mov [esi+2],al
		jmp return
;computer player plays in random open spot
generate_move:
	mov esi,offset board
	mov eax,9																				;n-1 for range [0,8]
	call RandomRange
check_spot:
	add esi,eax
	mov dl,[esi]
	cmp dl,' '																				;see if generated spot is open
	je write_move
	jmp generate_move
write_move:
	mov al,'O'
	mov [esi],al
return:
ret
comp_turn_o ENDP

;procedure to prompt human to take turn for player O
hum_turn_o PROC
prompt:
	call crlf
	mov edx, offset human_o_prompt
	call WriteString																	;prompt user for move
	call crlf
	call ReadDec
	mov human_move, eax																	;store move
	mov esi, offset board
check_open:																				;confirm that user entered spot is open
	add esi, human_move
	mov al,[esi]
	cmp al, ' '
	je write																			;write if spot is open
	jmp prompt																			;prompt user for new spot otherwise
write:
	mov al, 'O'
	mov [esi], al																		;change cell selected by player to X
ret
hum_turn_o ENDP

;procedue to check if player x has 3 in a row anywhere on the board, if true returns 'y' in eax
check_win_x PROC
mov esi, offset board

;check row 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if row one has three x's in a row
je win

;check row 2 for win
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if row two has three x's in a row
je win

;check row 3 for win
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if row three has three x's in a row
je win

;check column 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if column one has three x's in a row
je win

;check column 2 for win
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if column two has three x's in a row
je win

;check column 3 for win
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if column three has three x's in a row
je win

;check diag 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if diag one has three x's in a row
je win

;check diag 2 for win
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 264																			;check if diag two has three x's in a row
je win
jmp no_win
win:
	mov eax, 0																		;clear eax
	mov eax, 'y'																	;return 'y' in eax if x has won
	jmp return
no_win:
	mov eax, 0
	mov eax, 'n'																	;return not 'y' if no winning condition is found
return:
ret
check_win_x ENDP

;procedue to check if player o has 3 in a row anywhere on the board, if true returns 'y' in eax
check_win_o PROC
mov esi, offset board

;check row 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+1]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if row one has three o's in a row
je win

;check row 2 for win
mov edx,0
mov eax,0
mov al, [esi+3]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+5]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if row two has three o's in a row
je win

;check row 3 for win
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+7]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if row three has three o's in a row
je win

;check column 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+3]
movzx ax,al
add dx,ax
mov al, [esi+6]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if column one has three o's in a row
je win

;check column 2 for win
mov edx,0
mov eax,0
mov al, [esi+1]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+7]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if column two has three o's in a row
je win

;check column 3 for win
mov edx,0
mov eax,0
mov al, [esi+2]
movzx dx, al
mov al, [esi+5]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if column three has three o's in a row
je win

;check diag 1 for win
mov edx,0
mov eax,0
mov al, [esi]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+8]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if diag one has three o's in a row
je win

;check diag 2 for win
mov edx,0
mov eax,0
mov al, [esi+6]
movzx dx, al
mov al, [esi+4]
movzx ax,al
add dx,ax
mov al, [esi+2]
movzx ax,al
add dx,ax
cmp dx, 237																			;check if diag two has three o's in a row
je win
jmp no_win
win:
	mov eax, 0																		;clear eax
	mov eax, 'y'																	;return 'y' in eax if o has won
	jmp return
no_win:
	mov eax, 0
	mov eax, 'n'																	;return not 'y' if no winning condition is found
return:
ret
check_win_o ENDP

END