totalgame = 25000; %25k
win = 0;
wingrid = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];%25 elements big, only look at 1-10
dealcard = [0,0,0,0,0,0,0,0,0,0]; %10 elements just in case
select = 1; %points to card in hand
dealercheck = true; %if true remain checking
noace = true; %check if dealer has no ace or changed 11 to 1
%dealertop = 0; %record top card
%ceil(rand()*10)+1   2-11
for n=3:20, %total in player hand
%for n=19:20, %debug
	for x=2:11, %starting dealer card
	%for x=9:11, %debug
		for a=1:totalgame,
			%fprintf('win: %d\n', win); %debug show win total
			dealercheck = true; %reset checks
			noace = true;
			select = 2; %offset for increment in loop
			dealcard(1) = x; %set dealer 1st card
			dealcard(select) = ceil(rand()*10)+1;
			while(dealercheck), %loop until 17<=dealer<=21
				%fprintf('dealer total: %d\n', sum(dealcard)); %debug show win total
				%fprintf('player: %d  dealer: %d\n', n, sum(dealcard)); %debug show player vs dealer
				%disp(dealcard);
				if((sum(dealcard)<n)||(sum(dealcard)<17)), %if dealer less than 17 or player total
					select = select+1;
					dealcard(select) = ceil(rand()*10)+1;
				elseif(sum(dealcard)>21), %if exceeding 21
					for m=1:10, %check all cards for ace
						if(dealcard(m)==11), %change first ace to 1 and compare again
							noace = false;
							dealcard(m)=1;
							break;
						else,
							noace = true;
						end;
					end;
					if(noace), %if no aces left to change
						win = win+1;  %increment win
						%fprintf('player win\n\n'); %debug
						dealercheck = false;
					end;
				else,  %dealer wins
					%win = win+1;
					%fprintf('dealer win\n\n'); %debug
					dealercheck = false;
				end;
			end;
            %fprintf('game: %d  dealer total: %d\n', a, sum(dealcard)); %debug
            %dealertop = dealcard(1);  %obsolete
            dealcard = [0,0,0,0,0,0,0,0,0,0];
		end;
        wingrid(x-1) = win/totalgame; %find win percentage
		%fprintf('win: %d\n', win); %debug show win total
		%fprintf('value in hand: %d  dealer card up: %d  percent win: %f\n', n, dealertop, win/totalgame); %average out game
		dealcard = [0,0,0,0,0,0,0,0,0,0]; %reset dealer cards
		win = 0;
	end;
    fprintf('player total: %d\n', n);
	%fprintf('dealer face up card\n');
	%fprintf('[2, 3, 4, 5, 6, 7, 8, 9, 10, 11]');
    disp(wingrid);
    fprintf('\n');
end;