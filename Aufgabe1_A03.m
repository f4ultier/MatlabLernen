clc
clear
close
%% Der Begrüßungstext mit Erklärung von ein paar Regeln
disp("Willkommen zu BlackJack!");
disp("Das Spiel ist einfach, bitte gebe als erste an ob du spielen möchtest mit Y oder N.");
disp("Dein Ziel ist es möglich genau 21 Punkte zu sammeln aber auf keinen Fall mehr.");
disp("Wenn du genau 21 Punkte hast dann hast du einen BlackJack.");
disp("Zahlen Karten sind so viel wert wie sie zeigen, Bild Karten sind 10 wert.");
disp("Das Ass ist entweder 1 oder 11 wert jenachdem wie es für dich besser ist.");
disp("Wenn das Spiel anfängt hast du zwei Möglichkeiten:");
disp("1. Du möchtest eine weitere Karte dann schreibst du hit");
disp("2. Du möchtest keine weiter Karte und gucken was der Dealer hat, dann schreibst du stand");
disp("Viel Erfolg!");

%% Hier werden die Karten erzeugt 
cards = cell(13,2);
    %Karten werden in einem Cell-Array gespeichert um gleichzeigtig Strings und Zahlen verwenden zu können
cards{1,1}= "Ass";
cards{1,2}= 11; 
cards{2,1}= "Zwei";
cards{2,2}= 2; 
cards{3,1}= "Drei";
cards{3,2}= 3; 
cards{4,1}= "Vier";
cards{4,2}= 4; 
cards{5,1}= "Fünf";
cards{5,2}= 5; 
cards{6,1}= "Sechs";
cards{6,2}= 6; 
cards{7,1}= "Sieben";
cards{7,2}= 7; 
cards{8,1}= "Acht";
cards{8,2}= 8; 
cards{9,1}= "Neun";
cards{9,2}= 9; 
cards{10,1}= "Zehn";
cards{10,2}= 10; 
cards{11,1}="Bube";
cards{11,2}= 10; 
cards{12,1}= "Dame";
cards{12,2}= 10; 
cards{13,1}= "König";
cards{13,2}= 10; 

%% Initialisierung von einigen wichtigen Variablen und Matrizen
playerHand = zeros(11,1);
playerScore = sum(playerHand);
dealerHand = zeros(11,1);
dealerScore = sum(dealerHand);
    %Die Karten die Spieler und Dealer ziehen werden in einem Vektor
    %gespeichert damit Asse leichter zu handhaben sind es ist aber gut möglich
    %das dies nicht nötig ist und könnte vermutlich optimiert werden gerne
    %feedback da lassen :) 
runde = 1; 
dRunde = 1; 
aceCounter = 0; 
dAceCounter = 0;
userChoice = "hit";
%% Start des Spiels
userInput = input("Möchtest du ein Spiel starten ? [Y/N]","S");
if userInput == "Y"
%% Erste Hand des Dealers 
     dr = randi([1,13]);    %ein zufälliger int zwischen 1 und 13 wird generiert
     if dr == 1, dAceCounter = dAceCounter +1 ; end            
        %Falls die zufällige Zahl 1 als ein Ass ist wollen wir den Ass Counter erhöhen
     dealerHand(dRunde,1)= cards{dr,2}; 
        %wir ändern den Eintrag im Hand Vektor des Dealers der der
        %aktuellen Runde(dRunde) entspricht zum Wert der gezogenen Karte
     dealerText = ["Der  Dealer hat: ", cards{dr,1}]; 
        %Dem Spieler wird die gezogenen Karte angezeigt
     disp(dealerText);
     dRunde = dRunde +1;        
        %Rundescore wird erhöht um beim nächsten mal den richtigen Eintrag zu ändern
     dealerScore = sum(dealerHand);

%% While loop für die Phase in der der Spieler mehr Karten möchte
        while userChoice == "hit"
            r = randi([1,13]);  
                %Hier passiert das gleiche wie oben beim Dealer nur für den Spieler
            if r == 1, aceCounter = aceCounter + 1; end
                %AceCounter wird verwendet damit im Fall das der Spieler über
                %21 Punkte hat direkt geguckt werden kann ob ein Ass von 11
                %zu 1 geändert werden kann und man nicht erst durch den
                %Hand vektor iterrieren muss um zu gucken ob irgendwo ein
                %Ass liegt
            playerHand(runde,1) = cards{r,2};
            text = ["Deine Karte ist: ", cards{r,1}];
            disp(text);
            runde = runde + 1; 
            playerScore = sum(playerHand);
                
                if playerScore > 21
                    %Nach jeder gezogenen Karte wird geguckt ob der Spiel verloren hat weil
                    %er/sie über 21 Punkte hat
                    if aceCounter >= 1 
                        %prüfe ob Spieler ein Ass hat
                        aceCounter = aceCounter -1;
                        for a1=1: runde
                            if playerHand(a1,1) == 11 
                                playerHand(a1,1) = 1; 
                                disp("Dein Ass ist jetzt 1 Wert");
                                playerScore=sum(playerHand);
                                    %Der Vorteil hier ist das man auch den Fall
                                    %von mehreren Assen abdeckt 
                                break;
                            end
                        end
                    else 
                        disp("Über 21 Punkte, du hast leider verloren.");
                        return;
                    end


                end
                if playerScore == 21 
                    disp("BLACK JACK  BLACK JACK  BLACK JACK  BLACK JACK");
                    while dealerScore < 21 
                        %Der Dealer muss laut Regeln so lange ziehen bis er 17 Punkte hat aber 
                        %im Fall das der Spieler BJ hat will der Dealer
                        %auch weiter ziehen wenn er zwischen 17 und 21
                        %liegt

                        %Wenn der Spieler ein BJ hat dann wird das spiel direkt gestoppt und es
                        %wird geprüft welche Karten der Dealer hat hier kann es nur noch zu einem
                        %Unentschieden oder einem Sieg für den Spieler kommen

                         dr = randi([1,13]);
                         if dr == 1,dAceCounter = dAceCounter +1; end
                         dealerHand(dRunde,1)= cards{dr,2};
                         dealerText = ["Der  Dealer hat: ", cards{dr,1}];
                         disp(dealerText);
                         dRunde = dRunde +1; 
                         dealerScore = sum(dealerHand);
                             %Hier wird geprüft ob der Dealer ein Ass hat das
                             %von 11 auf 1 geändert werden kann
                         if dealerScore == 21
                             disp("Der Dealer hat auch ein Blackjack, es ist ein Unentschieden!");
                             return; 
                         end
                         if dealerScore > 21
                             if dAceCounter >= 1
                             dAceCounter = dAceCounter -1; 
                                 for b1=1: runde
                                     if dealerHand(b1,1)== 11
                                         dealerHand(b1,1)=1; 
                                         disp("Das Ass des Dealers ist jetzt 1 wert.")
                                         dealerScore = sum(dealerHand);
                                         break; 
                                     end
                                 end
                             else
                                 disp("Winner Winner, Chicken Dinner");
                                return;
                             end
                         end
                    end
                end

            userChoice = input("Was möchtetst du tun ? stand oder hit   ", "s");
        end
%% Der Spieler möchte keine Karten mehr und die Dealer Karten werden geprüft
        while userChoice == "stand"
                 dr = randi([1,13]);
                 if dr == 1,dAceCounter = dAceCounter+1; end
                 dealerHand(dRunde,1)= cards{dr,2};
                 dealerText = ["Der  Dealer hat: ", cards{dr,1}];
                 disp(dealerText);
                 dRunde = dRunde +1; 
                 dealerScore = sum(dealerHand);
%% Auswertung des Spiels                 
                 if dealerScore > 21
                     if dAceCounter >= 1
                         %Spezialfall wo der Dealer ein oder mehrere Asse besitzt
                         dAceCounter = dAceCounter -1; 
                         for c1=1: runde
                             if dealerHand(c1,1)== 11
                                 dealerHand(c1,1)=1; 
                                 disp("Das Ass des Dealers ist jetzt 1 wert.");
                                 dealerScore = sum(dealerHand);
                                 break; 
                             end
                         end
                     else
                         disp("Dealer went bust, du gewinnst!");
                         return; 
                     end
                 end 

                 if dealerScore >= 17
                     %Dealer muss bis 17 ziehen danach wird ausgewertet
                     if dealerScore > playerScore
                         disp("Der Dealer hat mehr Punkte, du hast verloren :( ");
                         return;
                     elseif dealerScore < playerScore
                         disp("Du hast mehr Punkte und gewinnst!");
                         return; 
                     elseif dealerScore == playerScore
                         disp("Es ist ein Unentschiede");
                         return; 
                     end

                end
        end
end
