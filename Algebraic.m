function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

  data = dlmread(nume, ' ', 0, 0);
  s = data(1, 1);
  M(1:s,1:s) = data(2:s + 1,:);
  val1 = data((s + 2), 1);
  val2 = data((s + 3), 1);
  
  A = zeros(s, s);
  for i = 1 : s
    for j = 3 : length(data(i+1,:))
      if data(i + 1, j) != 0
        A(i, data(i + 1, j)) = 1;
      endif
      if i == data(i + 1, j)
        A(i, data(i + 1, j)) = 0;
        M(i, 2) = M(i, 2) - 1;
      endif
    endfor
  endfor
  
  K = zeros(s, s);
  for i = 1 : s
    for j = 1 : s
      K(i, j) = A(i, j) / M(i, 2);
    endfor
  endfor
  K = transpose(K);
  G = eye(s) - d .* K;
  R = inv(G) * (((1 - d) / s) * ones(s, 1));
  R = R / norm(R, 1);
  output_precision(6);
endfunction