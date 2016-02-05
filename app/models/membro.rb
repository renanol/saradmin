class Membro < ActiveRecord::Base

  belongs_to :user
  belongs_to :pessoa
  belongs_to :igreja
  belongs_to :cargo

  has_many :contribuicaos

  accepts_nested_attributes_for :pessoa
  accepts_nested_attributes_for :contribuicaos

  validates :igreja_id, presence: true
  validates :cargo_id, presence: true



  def to_s
    pessoa
  end

  def nome_igreja
    unless (self.igreja.nil?)
      self.igreja.descricao
    end
  end

  def igrejas_ids
    ids = Array.new

    igrejas = Igreja.where(responsavel_id: self.id)

    if igrejas.length > 0
      igrejas.each do |r|
        ids << r.id
      end
    else
      ids << -1
    end

    return ids
  end

  def redes_ids
    ids = Array.new

    redes = Rede.where(responsavel_id: self.id)

    redes += Rede.where(igreja_id: self.igrejas_ids)

    if redes.length > 0
      redes.each do |r|
        ids << r.id
      end
    else
      ids << -1
    end

    return ids
  end

  def equipes_ids
    ids = Array.new

    equipes = Equipe.where(responsavel_id: self.id)

    equipes += Equipe.where(rede_id: self.redes_ids)

    if equipes.length > 0
      equipes.each do |e|
        ids << e.id
      end
    else
      ids << -1
    end

    return ids
  end

  def sub_equipes_ids
    ids = Array.new

    sub_equipes = SubEquipe.where(responsavel_id: self.id)

    sub_equipes += SubEquipe.where(equipe_id: self.equipes_ids)

    if sub_equipes.length > 0
      sub_equipes.each do |se|
        ids << se.id
      end
    else
      ids << -1
    end

    return ids
  end

  def celulas_ids
    ids = Array.new

    celulas = Celula.where(responsavel_id: self.id)

    celulas += Celula.where(sub_equipe_id: self.sub_equipes_ids)

    if celulas.length > 0
      celulas.each do |c|
        ids << c.id
      end
    else
      ids << -1
    end

    return ids
  end

end
