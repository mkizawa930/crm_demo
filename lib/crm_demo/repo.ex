defmodule CrmDemo.Repo do
  use Ecto.Repo,
    otp_app: :crm_demo,
    adapter: Ecto.Adapters.Postgres
end
