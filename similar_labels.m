function similar_labels(label_emb, doc_vector, label_vocab, topn)
%%
%   A function to list similar words to the given 'word' based on the model
%   model: a matrix of d x V dimensions where d is the size of word vectors and V is the number of words
%   word: string
%   vocab: a cell of words in vocabulary
%   topn: use to determine how many words will be listed
%
%   Example
%
%   model_filepath = 'word2vec_model.bin';    
%   vocab_filepath = 'word2vec_vocab.txt';    % Each line of the vocabulary file should contain word and its frequency (tab separated)
%
%   f = fopen(model_filepath,'rb');
%   d = fread(f,1,'int64');
%   V = fread(f,1,'int64');
%   model = reshape(fread(f,inf,'real*4=>single'), d, V);
%   model = bsxfun(@rdivide,model,sqrt(sum(model.^2,1)));
%
%   vocab = textscan(fopen(vocab_filepath),'%s%d');
%   vocab = vocab{1};     % ignore word frequencies
%
%   similar_words(model, 'world', vocab, 20);
%
%
%%

  if nargin < 4
    topn = 20;
  end

  similarity = sum(bsxfun(@times, label_emb, doc_vector),1);

  [sorted_similarity, ranking] = sort(similarity,'descend');

  for k = 1:topn
    fprintf(1,'%d) %s\t%.4f\n', k, label_vocab{ranking(k)}, sorted_similarity(k));
  end

end
