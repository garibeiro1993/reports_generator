defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected_response =
        %{
          "foods" => %{
            "açaí" => 1,
            "churrasco" => 2,
            "esfirra" => 3,
            "hambúrguer" => 2,
            "pastel" => 0,
            "pizza" => 2,
            "prato_feito" => 0,
            "sushi" => 0
          },
          "users" => %{
            "1" => 48,
            "10" => 36,
            "11" => 0,
            "12" => 0,
            "13" => 0,
            "14" => 0,
            "15" => 0,
            "16" => 0,
            "17" => 0,
            "18" => 0,
            "19" => 0,
            "2" => 45,
            "20" => 0,
            "21" => 0,
            "22" => 0,
            "23" => 0,
            "24" => 0,
            "25" => 0,
            "26" => 0,
            "27" => 0,
            "28" => 0,
            "29" => 0,
            "3" => 31,
            "30" => 0,
            "4" => 42,
            "5" => 49,
            "6" => 18,
            "7" => 27,
            "8" => 25,
            "9" => 24
          }
        }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "when a file list is provided, builds the report" do
      filenames = ["report_1.csv", "report_1.csv"]

      response = ReportsGenerator.build_from_many(filenames)

      expected_response =
        {:ok,
          %{
            "foods" => %{
              "açaí" => 25_086,
              "churrasco" => 25_170,
              "esfirra" => 24_936,
              "hambúrguer" => 25_186,
              "pastel" => 24_898,
              "pizza" => 24_852,
              "prato_feito" => 24_972,
              "sushi" => 24_900
            },
            "users" => %{
              "1" => 188_230,
              "10" => 177_502,
              "11" => 179_582,
              "12" => 185_622,
              "13" => 185_804,
              "14" => 180_326,
              "15" => 190_392,
              "16" => 182_200,
              "17" => 187_138,
              "18" => 183_382,
              "19" => 181_828,
              "2" => 184_946,
              "20" => 180_606,
              "21" => 180_702,
              "22" => 188_786,
              "23" => 189_412,
              "24" => 181_842,
              "25" => 181_938,
              "26" => 178_000,
              "27" => 180_978,
              "28" => 187_148,
              "29" => 176_894,
              "3" => 181_386,
              "30" => 183_476,
              "4" => 182_788,
              "5" => 182_494,
              "6" => 181_374,
              "7" => 186_052,
              "8" => 185_856,
              "9" => 183_540
            }
          }}

      assert response == expected_response
    end

    test "when a file list is not provided, returns an error" do
      response = ReportsGenerator.build_from_many("banana")

      expected_response = {:error, "Please provide a list of strings"}

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', returns the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when the option is 'foods', returns the most consumed food" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when invalid option is given, returns an error" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("invalid_options")

      expected_response = {:error, "Invalid option"}

      assert response == expected_response
    end
  end
end
