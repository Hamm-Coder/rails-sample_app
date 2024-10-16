class ListsController < ApplicationController

  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

  def create
    #1.&2. データを受取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    #3. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
    #4-1 トップ画面へリダイレクト
      redirect_to list_path(@list.id)
    else
    #4-2 指定アクション名で同一コントローラー内の別アクションのviewを表示する。
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy #destroy
    list = List.find(params[:id])# ListModelから、Paramsで、idカラム指定の該当IDのレコードを1件取得
    list.destroy #データ(レコード)削除
    redirect_to '/lists' #リダイレクトlists View
  end

  private

  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end

end
