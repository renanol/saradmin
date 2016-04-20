class AddFunctionMembroSubEquipes < ActiveRecord::Migration
  def self.up
    execute <<-__EOI
    CREATE OR REPLACE FUNCTION public.membro_sub_equipes (
      _membro_id_ INTEGER
    )
    RETURNS VARCHAR AS
    $body$
      BEGIN

        RETURN (
          SELECT string_agg(se.descricao, ', ')
          FROM sub_equipes se
          WHERE se.id IN (
            SELECT c.sub_equipe_id
            FROM celula_membros cm
              JOIN celulas c ON c.id = cm.celula_id
            WHERE cm.membro_id = _membro_id_
          )
        );

      END;
    $body$
    LANGUAGE 'plpgsql'
    VOLATILE
    CALLED ON NULL INPUT
    SECURITY INVOKER
    COST 100;
    __EOI
  end

  def self.down
    execute "DROP FUNCTION IF EXISTS membro_sub_equipes(INTEGER);"
  end
end
