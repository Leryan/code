/**
 * New BSD Licence.
 */

package syracuse;

/**
 * @author akregator
 *
 */
public class Syracuse {
		private long iters;
		private long value;
		private long score;
		private long calc;
		private long from;
		private long max_numbers;

		Syracuse(long from, long max_numbers)
		{
			this.setFrom(from);
			this.setMax_numbers(max_numbers);
		}
		/*************** SETTERS ****************/
		public void setFrom(long from) {
			this.from = from;
		}
		public void setMax_numbers(long max_numbers) {
			this.max_numbers = max_numbers;
		}
		/*************** GETTERS ****************/
		public long getMax_numbers() {
			return this.max_numbers;
		}
		public long getFrom() {
			return this.from;
		}
		/************** FUNCTIONS ***************/
		public void computeSyracuse()
		{
	        for(this.value = getFrom(); this.iters < getMax_numbers(); this.value++)
	        {
	        	this.iters = 0;
	        	this.calc = this.value;
	            while(this.calc != 1)
	            {
	                if(this.calc % 2 == 0)
	                {
	                	this.calc /= 2;
	                }
	                else
	                {
	                	this.calc = (3 * this.calc + 1) / 2;
	                	this.iters++;
	                }
	                this.iters++;
	            }
	            if(this.iters > this.score)
	            {
	            	this.score = this.iters;
	                this.toString();
	            }
	        }
		}
		@Override
		public String toString()
		{
			System.out.println(this.value + " with " + this.score + " numbers.");
			return null;
		}
}
