class CreateProdureMembroCelulas < ActiveRecord::Migration
  def self.up
    execute <<-__EOI
    CREATE OR REPLACE FUNCTION public.membro_celulas (
      _membro_id_ INTEGER
    )
    RETURNS VARCHAR AS
    $body$
      BEGIN

        RETURN (
          SELECT string_agg(c.descricao, ', ')
          FROM celula_membros cm
            JOIN celulas c ON c.id = cm.celula_id
          WHERE cm.membro_id = _membro_id_
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
    execute "DROP FUNCTION IF EXISTS membro_celulas(INTEGER);"
  end
end
