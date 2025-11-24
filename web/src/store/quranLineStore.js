export class QuranLineStore {
  #dbClient;
  #apiClient;
  #storeName = "quranLine";
  #url = "quranline.php"

  constructor(dbClient, apiClient) {
    this.#dbClient = dbClient;
    this.#apiClient = apiClient
  }

  async getByKey(index, key) {
    await this.#loadData();
    return await this.#dbClient.getByIndex(this.#storeName, index, `${key}`);
  }

  async #loadData() {
    var count = await this.#dbClient.count(this.#storeName);
    if (count === 0) {
      let dataList = await this.#apiClient.get(this.#url + "?quran_id=simple");
      let dataListWithId = dataList.map(obj => ({ id: `simple_${obj.line}`, ...obj }));
      await this.#dbClient.addList(this.#storeName, dataListWithId);

      dataList = await this.#apiClient.get(this.#url + "?quran_id=en.sahih");
      dataListWithId = dataList.map(obj => ({ id: `en.sahih_${obj.line}`, ...obj }));
      await this.#dbClient.addList(this.#storeName, dataListWithId);
    }
  }

}
