unit uBusinessProposal.SQLBuilder.MySQL;

interface

uses
  uBusinessProposal.SQLBuilder.Interfaces,
  uBusinessProposal.SQLBuilder;

type
  TBusinessProposalSQLBuilderMySQL = class(TBusinessProposalSQLBuilder, IBusinessProposalSQLBuilder)
  public
    constructor Create;
    class function Make: IBusinessProposalSQLBuilder;

    // BusinessProposal
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TBusinessProposalSQLBuilderMySQL }

constructor TBusinessProposalSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBusinessProposalSQLBuilderMySQL.Make: IBusinessProposalSQLBuilder;
begin
  Result := Self.Create;
end;

function TBusinessProposalSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `business_proposal` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `person_id` bigint(20) DEFAULT NULL, '+
            '   `requester` varchar(100) DEFAULT NULL, '+
            '   `expiration_date` date NOT NULL, '+
            '   `delivery_forecast` varchar(100) DEFAULT NULL, '+
            '   `seller_id` bigint(20) NOT NULL, '+
            '   `note` text, '+
            '   `internal_note` text, '+
            '   `payment_term_note` text, '+
            '   `status` tinyint(4) NOT NULL COMMENT ''[0..2] 0-Pendente, 1-Aprovada, 2-Cancelada'', '+
            '   `sum_business_proposal_item_total` decimal(18,4) DEFAULT NULL,'+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `business_proposal_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `business_proposal_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   KEY `business_proposal_fk_person_id` (`person_id`), '+
            '   KEY `business_proposal_fk_seller_id` (`seller_id`), '+
            '   KEY `business_proposal_idx_status` (`status`), '+
            '   KEY `person_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `business_proposal_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`) , '+
            '   CONSTRAINT `business_proposal_fk_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) , '+
            '   CONSTRAINT `business_proposal_fk_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `person` (`id`) , '+
            '   CONSTRAINT `business_proposal_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `business_proposal_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' )  ';
end;

function TBusinessProposalSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
