
function NewChrIx = Sus(Fitnv,nsel)
% ����:
% FitnV  �������Ӧ��ֵ
% Nsel   ��ѡ��������Ŀ
% ���:
% NewChrIx  ��ѡ������������
% Identify the population size (Nind)
   [Nind,ans] = size(Fitnv);

% Perform stochastic universal sampling
   cumfit = cumsum(Fitnv);
   trials = cumfit(Nind) / nsel * (rand + (0:nsel-1)');
   Mf = cumfit(:, ones(1, nsel));
   Mt = trials(:, ones(1, Nind))';
   [NewChrIx, ans] = find(Mt < Mf & [ zeros(1, nsel); Mf(1:Nind-1, :) ] <= Mt);

% Shuffle new population
   [ans, shuf] = sort(rand(nsel, 1));
   NewChrIx = NewChrIx(shuf);


% End of function