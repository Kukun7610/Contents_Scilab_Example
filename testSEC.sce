 = ["one a";"b";"c and a word"];

// only works for ASCII
function p=censor_odds(str)
    odds = (0:((length(str)-1)/2))*2+1;
    p = ascii(str);
    p(odds) = ascii('#');
    p = ascii(p);
endfunction

for i = 1:size(a,'r')
  res(i) = censor_odds(a(i));
end

function p=censor_odds_i(i, max_len) // pass an index and the max length
    strlen = length(a(i));
    odds = (0:((strlen-1)/2))*2+1;
    p = ascii(a(i)+blanks(max_len-strlen));
    p(odds) = ascii('#');
endfunction

function v=censor_v(codes)
    for i = 1:size(codes,'r')
        v(i) = ascii(codes(i,:))
    end
endfunction

len = max(length(a));
res = censor_v(parallel_run(1:size(a,'r'), len, "censor_odds_i",len)');
