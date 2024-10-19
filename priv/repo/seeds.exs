# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CrmDemo.Repo.insert!(%CrmDemo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CrmDemo.Repo

alias CrmDemo.Customers
alias CrmDemo.Customers.Customer

Repo.delete_all(Customer)

Customers.create_customer(%{
  profiles: [
    %{
      profile_type: :corporation,
      label: "個人顧客",
      email: "abc@abc.co.jp",
      phone_number: "010-0000-1111",
      is_primary: true,
      index: 0,
      corporation: %{
        corporate_name: "株式会社ABC",
        corporate_name_kana: "カブシキガイシャABC"
      }
    }
  ]
})
