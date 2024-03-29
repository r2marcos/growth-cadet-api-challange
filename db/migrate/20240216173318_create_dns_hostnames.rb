class CreateDnsHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :dns_records do |t|
      t.string :ip_address

      t.timestamps
    end

    create_table :hostnames do |t|
      t.string :hostname

      t.timestamps
    end

    create_table :dns_records_hostnames, id: false do |t|
      t.belongs_to :dns_record
      t.belongs_to :hostname
    end
  end
end
