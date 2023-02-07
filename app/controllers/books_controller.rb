class BooksController < ApplicationController
  
  
  def create
    # データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    #データをデータベースに保存するためのsaveメソッド実行
    if @book.save
     
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books=Book.all
    @book = Book.new #投稿したものを受け取るための箱を準備した
  end

  def show
    @book = Book.find(params[:id])  #パラメーターに送られているidの値を取得する
  end

  def edit
     @book = Book.find(params[:id]) #特定のidを元に本を探す
  end
  
  def update
    @book= Book.find(params[:id])
    
    if @book.update(book_params)
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book.id) #showアクションを介してviewをひょうじ
    else 
       render :edit #editアクションを介さずにviewを表示させる
    end
    
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
