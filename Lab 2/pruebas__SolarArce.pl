%mini script profesor
/*

station(1, "Los Heroes", t, 50, E1),
station(2, "La moneda", r, 30, E2),
station(3, "Universidad de Chile", t, 30, E3),
line(1, "L1", "UIC 60 ASCE", [], L1),
section(E1, E2, 500, 100, S0),
section(E2, E3, 550, 100, S1),
lineAddSection(L1, S0, L1_1),
lineAddSection(L1_1, S1, L1_2),
subway(1, "Metro Santiago", Sub0),
isLine(L1_2),
% isLine(L1_1), % False porque falta estaci�n terminal
% subwayAddLine(Sub0, [L1_1], Sub2). % False porque la l�nea es inconsistente
subwayAddLine(Sub0, [L1_2], Sub2).

*/


%adaptacion del script de pruebas a prolog

/*
station(0, "San Pablo", "t", 90, E0),
station(1, "Neptuno", "r", 45, E1),
station(2, "Pajaritos", "t", 45, E2),
station(3, "Las Rejas", "r", 45, E3),
station(4, "Ecuador", "r", 60, E4),
station(5, "San Alberto Hurtado", "r", 40, E5),
station(6, "Universidad de Santiago de Chile", "c", 40, E6),
station(7, "Estación Central", "c", 3600, E7),
station(8, "Unión Latinoamericana", "r", 30, E8),
station(9, "República", "r", 40, E9),
station(10, "Los Héroes", "c", 60, E10),
station(11, "La Moneda", "r", 40, E11),
station(12, "Universidad de Chile", "c", 90, E12),
station(13, "Santa Lucía", "r", 40, E13),
station(14, "Universidad Católica", "c", 60, E14),
station(15, "Baquedano", "r", 40, E15),
station(16, "Los Dominicos", "t", 90, E16),
station(17, "Cochera Neptuno", "m", 3600, E17),
station(18, "El Llano", "r", 60, E18),
station(19, "Franklin", "r", 50, E19),
station(20, "Rondizzoni", "r", 55, E20),
station(21, "Parque O'Higgins", "r", 65, E21),
station(22, "Toesca", "r", 65, E22),
station(23, "Santa Ana", "c", 65, E23),
station(24, "Puente Cal y Canto", "r", 65, E24),
section(E0, E1, 4 ,15, S0),
section(E1, E2, 3, 14, S1),
section(E2, E3, 2.5, 10, S2),
section(E3, E4, 4.5, 17, S3),
section(E4, E5, 4.7, 18, S4),
section(E5, E6, 4.3, 17, S5),
section(E6, E7, 3.8, 12, S6),
section(E7, E8, 2.5, 10, S7),
section(E8, E9, 4.5, 17, S8),
section(E9, E10, 4.7, 18, S9),
section(E10, E11, 4.3, 17, S10),
section(E11, E12, 3.8, 12, S11),
section(E12, E13, 4.5, 17, S12),
section(E13, E14, 4.7, 18, S13),
section(E14, E15, 4.3, 17, S14),
section(E15, E16, 4.2, 17, S15),
section(E1, E17, 3.8, 12, S16),
section(E18, E19, 4, 15, S17),
section(E19, E20, 3, 12, S18),
section(E20, E21, 5, 18, S19),
section(E21, E22, 4.5, 16, S20),
section(E22, E10, 4.2, 16, S21),
section(E10, E23, 4.2, 16, S22),
section(E23, E24, 4.2, 16, S23),
section(E24, E18, 28, 90, S24),
line(1, "Línea 1", "UIC 60 ASCE" ,[S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15],L1),
line(2,"Línea 2", "100 R.E.",[], L2),
lineLength(L1, LengthL1, DistanceL1, CostL1), %DistanceL1 = 64,3 ; LengthL1 = 16 ; CostL1 = 246
lineLength(L2, LengthL2, DistanceL2, CostL2),
lineSectionLength(L1,"San Pablo", "Las Rejas", PathSectionL1, DistanceSectionL1, CostSectionL1), % DistanceSectionL1 = 9.5 ; CostSectionL1 = 39
lineAddSection(L2,S17, L2A),
lineAddSection(L2A, S18, L2B),
lineAddSection(L2B, S19, L2C),
lineAddSection(L2C, S20, L2D),
lineAddSection(L2D, S21, L2E),
lineAddSection(L2E, S22, L2F),
lineAddSection(L2C, S23, L2G),
lineAddSection(L2D, S24, L2H),
%lineAddSection(L2H, S19, L2I),  %dependiendo de como implemente la función, esta operación no añade la estación duplicada. Puede lanzar un "error o excepción" (no un mensaje %de error como String, para no comprometer el recorrido de la función) o bien devolver la línea de entrada intacta. En este caso, l2i sería igual a l2h. 
isLine(L1),  %devuelve true
%isLine(L2),  %devuelve false
%isLine(L2E), %devuelve false
%isLine(L2H),  %devuelve true
pcar( 0, 100, "NS-74", "tr",PC0),
pcar( 1, 100, "NS-74", "ct",PC1),
pcar( 2, 150, "NS-74", "ct",PC2),
pcar( 3, 100, "NS-74", "ct",PC3),
pcar( 4, 100, "NS-74", "tr",PC4),
pcar( 5, 100, "AS-2014", "tr",PC5),
pcar( 6, 100, "AS-2014", "ct",PC6),
pcar( 7,100, "AS-2014", "ct",PC7),
pcar( 8, 100, "AS-2014", "ct",PC8),
pcar( 9, 100, "AS-2014", "tr",PC9),
pcar( 10, 100, "AS-2014", "tr",PC10),
pcar( 11, 100, "AS-2016", "ct",PC11),
pcar( 12, 100, "AS-2016", "ct",PC12),
pcar( 13, 150, "AS-2016", "ct",PC13),
pcar( 14, 100, "AS-2016", "ct",PC14),
pcar( 15, 100, "AS-2016", "ct",PC15),
pcar( 16, 100, "AS-2016", "ct",PC16),
pcar( 17, 100, "AS-2016", "tr",PC17),
train(0, "CAF", "UIC 60 ASCE", 60, [], T0),
train(1, "CAF", "UIC 60 ASCE", 70, [PC0, PC1, PC2, PC3, PC4], T1),
train(2, "CAF", "100 R.E.", 70, [PC5, PC6, PC7, PC8, PC9], T2), 
%train(3, "CAF", "100 R.E.", 70,[PC10, PC11, PC12, PC13, PC14, PC15, PC16, PC17], T3), 
%train(4, "CAF", "100 R.E.", 70,[PC1, PC2, PC3], T4),
%train(5, "CAF", "100 R.E.", 70,[PC0, PC5, PC9, PC12, PC17], T5),
trainAddCar( T0, PC5, 0,T0A),
trainAddCar( T0A, PC6, 1,T0B),
trainAddCar( T0B, PC7, 2,T0C),
trainAddCar( T0C, PC8, 3,T0D),
trainAddCar( T0D, PC9, 4, T0E), %tren valido
trainRemoveCar(T1, 0, T1A),
trainRemoveCar(T1, 2, T1B),
%isTrain(T0), %debe arrojar #f
isTrain(T1), %debe arrojar #t
isTrain(T2), %debe arrojar #t
%isTrain(T3), %debe arrojar #t
%isTrain(T4), %debe arrojar #f
%isTrain(T0A), %debe arrojar #f
%isTrain(T0B), %debe arrojar #f
%isTrain(T0C), %debe arrojar #f
%isTrain(T0D), %debe arrojar #f
isTrain(T0E), %debe arrojar #t
%isTrain(T1A), %debe arrojar #f
isTrain(T1B), %debe arrojar #t
%determinar capacidad del tren
trainCapacity(T0, CapacityTrainT0), % CapacityTrainT0 = 0
trainCapacity(T1, CapacityTrainT1), % CapacityTrainT1 = 550
driver( 0, "Juan", "CAF", D0 ),
driver( 1,"Alejandro", "Alsthom",D1),
driver( 2, "Diego", "Alsthom",D2),
driver( 2, "Pedro", "CAF", D3),
subway( 0, "Metro de Santiago",SW0),
subway( 1, "Subte",SW1),
subwayAddTrain(SW0, [T1, T2, T0E],SW0A),
subwayAddLine(SW0A, [L1, L2H], SW0B),
subwayAddDriver(SW0B, [D0, D1, D2, D3], SW0C),
subwayToString(SW0C, STRING).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%subway 1, Metro de amsterdam simplificado

/*
station(31, "Isolatorweg", "t", 120, MY_E1),
station(32, "Spaklerweg", "r", 110, MY_E2),
station(33, "Reigersbos", "c", 130, MY_E3),
station(34, "Gein", "r", 90, MY_E4),
station(35, "Gouverneurplein", "r", 100, MY_E5),
station(36, "Dijkgraafplein", "c", 140, MY_E6),
station(37, "Ganzenhoef", "r", 80, MY_E7),
station(38, "Zuidmeer", "r", 95, MY_E8),
station(39, "Centraal Station", "t", 180, MY_E9),
station(48, "Noord", "t", 150, MY_E10),
station(49, "Noorderpark", "r", 90, MY_E11),
station(50, "Vlugtlaan", "r", 120, MY_E12),
station(51, "De Vlugtlaan", "c", 100, MY_E13),
station(52, "Van der Madeweg", "r", 110, MY_E14),
station(53, "Zuid/WTC", "t", 180, MY_E15),
station(40, "Gaasperplas", "t", 120, MY_E16),
station(41, "Reigersbos", "c", 130, MY_E17),
station(42, "Gein", "r", 90, MY_E18),
station(43, "Holendrecht", "r", 110, MY_E19),
station(44, "Bullewijk", "c", 140, MY_E20),
station(45, "Bijlmermeer", "r", 100, MY_E21),
station(46, "Strandvliet", "r", 80, MY_E22),
station(47, "Centraal Station", "t", 180, MY_E23),
section(MY_E1, MY_E2, 50, 10, MY_S1),
section(MY_E2, MY_E3, 60, 12, MY_S2),
section(MY_E3, MY_E4, 40, 8, MY_S3),
section(MY_E4, MY_E5, 70, 14, MY_S4),
section(MY_E5, MY_E6, 50, 10, MY_S5),
section(MY_E6, MY_E7, 60, 12, MY_S6),
section(MY_E7, MY_E8, 30, 6, MY_S7),
section(MY_E8, MY_E9, 80, 16, MY_S8),
section(MY_E10, MY_E11, 80, 16, MY_S9),
section(MY_E11, MY_E12, 60, 12, MY_S10),
section(MY_E12, MY_E13, 40, 8, MY_S11),
section(MY_E13, MY_E14, 70, 14, MY_S12),
section(MY_E14, MY_E15, 10, 20, MY_S13),
section(MY_E16, MY_E17, 60, 12, MY_S14),
section(MY_E17, MY_E18, 40, 8, MY_S15),
section(MY_E18, MY_E19, 10, 20, MY_S16),
section(MY_E19, MY_E20, 50, 10, MY_S17),
section(MY_E20, MY_E21, 70, 14, MY_S18),
section(MY_E21, MY_E22, 30, 6, MY_S19),
section(MY_E22, MY_E23, 10, 24, MY_S20),
line(51, "Linea M51", "BS75A", [MY_S1, MY_S2, MY_S3, MY_S4, MY_S5, MY_S6, MY_S7, MY_S8], M51),
isLine(M51),
line(52, "Linea M52", "JIS50N",[], M52),
%isLine(52),
line(53, "Linea M53", "AREMA",[MY_S14, MY_S15, MY_S16, MY_S17], M53),
isLine(M53),
lineLength(M51, LengthM51, DistanceM51, CostM51), %DistanceM51 = 440 ; LengthM51 = 8 ; CostM51 = 88
lineSectionLength(M51, "Isolatorweg", "Zuidmeer", PathSectionM51, DistanceSectionM51, CostSectionM51),
%  DistanceSectionM51 = 360 ; CostSectionM51 = 72
lineAddSection(M52, MY_S10, M52D),
lineAddSection(M52D, MY_S11, M52E),
lineAddSection(M52E, MY_S12, M52F),
lineAddSection(M52F, MY_S13, M52G),
lineAddSection(M53, MY_S18, M53B),
lineAddSection(M53B, MY_S19, M53C),
lineAddSection(M53C, MY_S20, M53D),
pcar(10, 300, "Zilvermeeuw", "tr", MY_PC0),
pcar(11, 300, "Zilvermeeuw", "ct", MY_PC1),
pcar(12, 300, "Zilvermeeuw", "ct", MY_PC2),
pcar(13, 300, "Zilvermeeuw", "ct", MY_PC3),
pcar(14, 300, "Zilvermeeuw", "ct", MY_PC4),
pcar(15, 300, "Zilvermeeuw", "tr", MY_PC5),
pcar(16, 700, "CAF M4", "tr", MY_PC6),
pcar(17, 700, "CAF M4", "ct", MY_PC7),
pcar(18, 700, "CAF M4", "ct", MY_PC8),
pcar(19, 700, "CAF M4", "tr", MY_PC9),
pcar(20, 1200, "AK M5", "tr", MY_PC10),
pcar(21, 1200, "AK M5", "ct", MY_PC11),
pcar(22, 1200, "AK M5", "ct", MY_PC12),
pcar(23, 1200, "AK M5", "ct", MY_PC13),
pcar(24, 1200, "AK M5", "ct", MY_PC14),
pcar(25, 1200, "AK M5", "tr", MY_PC15),
train(9, "BN", "BS75A", 100, [MY_PC0, MY_PC1, MY_PC2, MY_PC3, MY_PC4, MY_PC5], BN),
%train(10, "BN", "BS75A", 100, [MY_PC0, MY_PC1, MY_PC2, MY_PC3, MY_PC4], BNX), %falta my-pc5, tren invalido, queda como lista vacia
train(11, "LHB", "JIS50N", 40, [MY_PC6, MY_PC7, MY_PC8, MY_PC9], LHB),
train(12, "OV", "AREMA", 80, [MY_PC10, MY_PC15], AREMA),
trainRemoveCar(BN, 5, BN1),
trainRemoveCar(BN1, 4, BN2),
trainRemoveCar(BN2, 3, BN3),
trainAddCar(BN3, MY_PC4, 3, BN4),
trainAddCar(BN4, MY_PC5, 4, BN5),
%isTrain(BNX),    %devuelve false
%isTrain(BN),
%isTrain(AREMA),
%isTrain(BN5),
trainCapacity(BN, CapacityTrainBN),    % CapacityTrainBN1 = 1800
trainCapacity(AREMA, CapacityTrainAREMA6), % CapacityTrainAREMA6 = 2400
trainCapacity(LHB, CapacityTrainLHB),    % CapacityTrainLHB = 2800
driver(10, "Miguelito", "BN", MY_D0),
driver(11, "Harambe", "LHB", MY_D1),
driver(12, "Pacheco", "OV", MY_D2),
subway(0, "Metro de Amsterdam", MY_SW0),
subway(1, "Metro de Paris", MY_SW1),
subway(2, "Metro de New York", MY_SW2),
subwayAddTrain(MY_SW0, [BN5, AREMA6, LHB], MY_SW0A),
subwayAddTrain(MY_SW1, [AREMA], MY_SW1A),
subwayAddTrain(MY_SW2, [BN], MY_SW2A),
subwayAddLine(MY_SW0A, [M51], MY_SW0B),
subwayAddLine(MY_SW0B, [M52G], MY_SW0C),
subwayAddLine(MY_SW0C, [M53D], MY_SW0D),
%subwayAddLine(MY_SW0A, [M51, M52G, M53D], MY_SW0X),
subwayAddDriver(MY_SW0D, [MY_D0], MY_SW0E),
subwayAddDriver(MY_SW0E, [MY_D1], MY_SW0F),
subwayAddDriver(MY_SW0F, [MY_D2], MY_SW0G),
%subwayAddDriver(MY_SW0X, [MY_D0, MY_D1, MY_D2], MY_SW0Z),

subwayToString(MY_SW0D, STRING1),
subwayToString(MY_SW0E, STRING2),
subwayToString(MY_SW0F, STRING3).

*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%metro hong kong, 2 lineas simplificadas
/*
% East Rail Line
station(100, "Admiralty", "c", 120, HK_E1),
station(101, "Exhibition Centre", "r", 80, HK_E2),
station(102, "Hung Hom", "c", 150, HK_E3),
station(103, "Mong Kok East", "r", 90, HK_E4),
station(104, "Kowloon Tong", "c", 110, HK_E5),
station(105, "Tai Wai", "c", 140, HK_E6),
station(106, "Sha Tin", "r", 100, HK_E7),
station(107, "Fo Tan", "r", 80, HK_E8),
station(108, "Racecourse", "r", 60, HK_E9),
station(109, "University", "r", 90, HK_E10),
station(110, "Tai Po Market", "r", 120, HK_E11),
station(111, "Tai Wo", "r", 100, HK_E12),
station(112, "Fanling", "r", 110, HK_E13),
station(113, "Sheung Shui", "r", 90, HK_E14),
station(114, "Lo Wu", "t", 150, HK_E15),
station(115, "Lok Ma Chau", "t", 130, HK_E16),
section(HK_E1, HK_E2, 40, 8, HK_S1),
section(HK_E2, HK_E3, 60, 12, HK_S2),
section(HK_E3, HK_E4, 50, 10, HK_S3),
section(HK_E4, HK_E5, 30, 6, HK_S4),
section(HK_E5, HK_E6, 70, 14, HK_S5),
section(HK_E6, HK_E7, 40, 8, HK_S6),
section(HK_E7, HK_E8, 20, 4, HK_S7),
section(HK_E8, HK_E9, 30, 6, HK_S8),
section(HK_E9, HK_E10, 50, 10, HK_S9),
section(HK_E10, HK_E11, 60, 12, HK_S10),
section(HK_E11, HK_E12, 40, 8, HK_S11),
section(HK_E12, HK_E13, 30, 6, HK_S12),
section(HK_E13, HK_E14, 20, 4, HK_S13),
section(HK_E14, HK_E15, 50, 10, HK_S14),
section(HK_E15, HK_E16, 40, 8, HK_S15),
line(200, "East Rail Line", "BS100A", [HK_S1, HK_S2, HK_S3, HK_S4, HK_S5, HK_S6, HK_S7, HK_S8, HK_S9, HK_S10, HK_S11, HK_S12, HK_S13, HK_S14, HK_S15], ERL),
% Tung Chung Line
station(120, "Tung Chung", "t", 150, HK_E20),
station(121, "Sunny Bay", "c", 100, HK_E21),
station(122, "Tsing Yi", "c", 120, HK_E22),
station(123, "Lai King", "c", 90, HK_E23),
station(124, "Nam Cheong", "c", 110, HK_E24),
station(125, "Olympic", "r", 80, HK_E25),
station(126, "Kowloon", "c", 140, HK_E26),
station(127, "Hong Kong", "t", 180, HK_E27),
section(HK_E20, HK_E21, 60, 12, HK_S20),
section(HK_E21, HK_E22, 40, 8, HK_S21),
section(HK_E22, HK_E23, 50, 10, HK_S22),
section(HK_E23, HK_E24, 30, 6, HK_S23),
section(HK_E24, HK_E25, 20, 4, HK_S24),
section(HK_E25, HK_E26, 70, 14, HK_S25),
section(HK_E26, HK_E27, 60, 12, HK_S26),
line(201, "Tung Chung Line", "AS80B", [HK_S20, HK_S21, HK_S22, HK_S23, HK_S24, HK_S25, HK_S26], TCL),
lineLength(ERL, LengthERL, DistanceERL, CostERL), % LengthERL = 15, DistanceERL = 640, CostERL = 128
lineLength(TCL, LengthTCL, DistanceTCL, CostTCL), % LengthTCL = 7, DistanceTCL = 330, CostTCL = 66
lineSectionLength(ERL, "Admiralty", "Fo Tan", PathSectionERL1, DistanceSectionERL1, CostSectionERL1), % PathSectionERL1 = [HK_S1, HK_S2, HK_S3, HK_S4, HK_S5, HK_S6, HK_S7], DistanceSectionERL1 = 290, CostSectionERL1 = 58
lineSectionLength(ERL, "Tai Wai", "Tai Po Market", PathSectionERL2, DistanceSectionERL2, CostSectionERL2), % PathSectionERL2 = [HK_S6, HK_S7, HK_S8, HK_S9, HK_S10], DistanceSectionERL2 = 190, CostSectionERL2 = 38
lineSectionLength(TCL, "Tung Chung", "Kowloon", PathSectionTCL, DistanceSectionTCL, CostSectionTCL), % PathSectionTCL = [HK_S20, HK_S21, HK_S22, HK_S23, HK_S24, HK_S25], DistanceSectionTCL = 270, CostSectionTCL = 54
line(202,"Tung Chung Line Extension", "AS80B",[], TCLE),
lineAddSection(TCLE, HK_S20, TCLE1),
lineAddSection(TCLE1, HK_S21, TCLE2),
lineAddSection(TCLE2, HK_S22, TCLE3),
lineAddSection(TCLE3, HK_S23, TCLE4),
isLine(ERL), % true
isLine(TCL), % true
%isLine(TCLE), % false
isLine(TCLE4), % true
pcar(150, 250, "SP1900", "tr", HK_PC1),
pcar(151, 250, "SP1900", "ct", HK_PC2),
pcar(152, 300, "SP1900", "ct", HK_PC3),
pcar(153, 250, "SP1900", "ct", HK_PC4),
pcar(154, 250, "SP1900", "tr", HK_PC5),
pcar(155, 200, "SP1950", "tr", HK_PC6),
pcar(156, 200, "SP1950", "ct", HK_PC7),
pcar(157, 220, "SP1950", "ct", HK_PC8),
pcar(158, 200, "SP1950", "tr", HK_PC9),
pcar(159, 180, "A-Train", "tr", HK_PC10),
pcar(160, 180, "A-Train", "ct", HK_PC11),
pcar(161, 200, "A-Train", "ct", HK_PC12),
pcar(162, 180, "A-Train", "tr", HK_PC13),
train(1, "Kinki Sharyo", "BS100A", 80, [], HK_T1),
train(2, "Kinki Sharyo", "BS100A", 80, [HK_PC1, HK_PC2, HK_PC3, HK_PC4, HK_PC5], HK_T2),
train(3, "Kawasaki Heavy Industries", "AS80B", 100, [HK_PC6, HK_PC7, HK_PC8, HK_PC9], HK_T3),
train(4, "CRRC Changchun", "AS80B", 90, [HK_PC10, HK_PC11, HK_PC12, HK_PC13], HK_T4),
trainAddCar(HK_T1, HK_PC10, 0, HK_T1A),
trainAddCar(HK_T1A, HK_PC11, 1, HK_T1B),
trainAddCar(HK_T1B, HK_PC12, 2, HK_T1C),
trainAddCar(HK_T1C, HK_PC13, 3, HK_T1D),
trainRemoveCar(HK_T4, 0, HK_T4A),
trainRemoveCar(HK_T4A, 0, HK_T4B),
isTrain(HK_T1D), % true
isTrain(HK_T2), % true
isTrain(HK_T3), % true
%isTrain(HK_T4A), % false
%isTrain(HK_T4B), % true
trainCapacity(HK_T1, CapacityHK_T1), % CapacityHK_T1 = 0
trainCapacity(HK_T2, CapacityHK_T2), % CapacityHK_T2 = 1300
trainCapacity(HK_T3, CapacityHK_T3), % CapacityHK_T3 = 820
trainCapacity(HK_T4, CapacityHK_T4), % CapacityHK_T4 = 740
driver(1, "John Smith", "Kinki Sharyo", HK_D1),
driver(2, "Michael Johnson", "Kinki Sharyo", HK_D2),
driver(3, "David Lee", "Kawasaki Heavy Industries", HK_D3),
driver(4, "James Wong", "CRRC Changchun", HK_D4),
subway(1, "Hong Kong MTR", HK_SW1),
subway(2, "Shenzhen Metro", HK_SW2),
subwayAddTrain(HK_SW1, [HK_T2, HK_T3], HK_SW1A),
subwayAddTrain(HK_SW1A, [HK_T4], HK_SW1B),
subwayAddLine(HK_SW1B, [ERL], HK_SW1C),
subwayAddLine(HK_SW1C, [TCL], HK_SW1D),
subwayAddLine(HK_SW1D, [TCLE4], HK_SW1E),
subwayAddDriver(HK_SW1E, [HK_D1, HK_D2, HK_D3], HK_SW1F),
subwayAddDriver(HK_SW1F, [HK_D4], HK_SW1G),
subwayToString(HK_SW1, STRING_HK_SW1),
subwayToString(HK_SW1G, STRING_HK_SW1G).

*/